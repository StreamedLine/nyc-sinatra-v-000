class FiguresController < ApplicationController
	set :views, Proc.new { File.join(root, "../views/figures") }

	get '/figures' do 
		@figures = Figure.all
		erb :index
	end

	get '/figures/new' do 
		@titles = Title.all
		@landmarks = Landmark.all
		erb :new
	end

	post '/figures/new' do 
		figure = Figure.create(params[:figure])
		figure.titles.create(name: params[:title][:name]) if params[:title][:name] != ""
		figure.landmarks.create(name: params[:landmark][:name]) if params[:landmark][:name] != ""

		redirect :"/figures/#{figure.id}"
	end

	get '/figures/:id' do
		@figure = Figure.find(params[:id])

		erb :show
	end

	get '/figures/:id/edit' do
		@figure = Figure.find(params[:id])
		@titles = Title.all
		@landmarks = Landmark.all

		erb :edit
	end

	post '/figures/:id' do
		figure = Figure.find(params[:id])
		figure.update(params[:figure])
		figure.titles.create(name: params[:title][:name]) if params[:title][:name] != ""
		figure.landmarks.create(name: params[:landmark][:name]) if params[:landmark][:name] != ""

		redirect :"/figures/#{params[:id]}"
	end
end