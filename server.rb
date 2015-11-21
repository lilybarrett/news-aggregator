require 'pry'
require "sinatra"
require 'csv'

get "/articles/new" do
  erb :new
end

post "/articles" do
  @article = params[:article]
  @url_info = params[:url_info]
  @description = params[:description]

  CSV.open("new_article.csv", "ab") do |file|
    file << [@article, @url_info, @description]
  end

  redirect "/articles"
end

get "/articles"  do
  @article_list = CSV.readlines("new_article.csv")
  erb :articles
end

get "/articles/:article_title" do
  @article_list = CSV.readlines("new_article.csv")
  @article_title = params[:article_title]

  erb :article_display 
end
