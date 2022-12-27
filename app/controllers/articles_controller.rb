class ArticlesController < ApplicationController
	before_action :is_authenticated_route
	before_action :can_perform_action_on_article?, only: [:edit, :update, :destroy ]
	before_action :get_all_articles, only: [:index]


	def index
	end


	def new
		@article = Article.new
	end

	def edit
		get_current_article
		@isEdit = params[:action] == 'edit'
		render :new, status: :unprocessable_entity
	end

	def show
		get_current_article
	end

	def create
		@article = Article.new(create_article_params)
		@article.user = get_current_user
		if @article.save
			redirect_to @article, notice: "Article created successfully"
		else
			p @article.errors.full_messages
			render :new, status: :unprocessable_entity
		end
	end


	def update
		get_current_article
		if @article.user.nil?
			@article.user = User.first
		end
		if @article.update(create_article_params)
			redirect_to articles_path, notice: "Article updated successfully"
		else
			render :new, status: :unprocessable_entity
		end
	end


	def destroy
		get_current_article

		if @article
			@article.destroy
			redirect_to articles_path,  notice: "Article deleted successfully"
		else
			render :index
		end
	end

	
	private

	def create_article_params
		params.require(:article).permit(:title, :description,)
	end

	def get_all_articles
		@articles = paginate_data(Article)
	end

	def get_current_article
		@article = Article.find(params[:id])
	end


	def can_perform_action_on_article?
		get_current_article
		if !is_loggedin_user?(@article.user_id)
			flash[:alert] = "Unauthorized access"
			redirect_back(fallback_location: root_path)
			return
		end 
	end


end