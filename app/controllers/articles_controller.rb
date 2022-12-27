class ArticlesController < ApplicationController
	before_action :is_authenticated_route
	before_action :get_all_articles, only: [:index]

	def index
	end


	def new
		@article = Article.new
	end

	def edit
		@article = Article.find(params[:id])
		@isEdit = params[:action] == 'edit'
		render :new, status: :unprocessable_entity
	end

	def show
		@article = Article.find(params[:id])
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
		@article = Article.find(params[:id])
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
		article = Article.find(params[:id])

		if article
			article.destroy
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

end