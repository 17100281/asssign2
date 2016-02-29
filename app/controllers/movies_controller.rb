class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # @movies = Movie.all
    x = params[:sort_by]
    @flagDate = ""
    @flagTitle = ""
    @movies = Movie.all.order(x)
    
    if x == "release_date" 
      @flagDate = "hilite"
      @flagTitle = ""
    elsif x == "title" 
      @flagDate = ""
      @flagTitle = "hilite"
    elsif x == nil
      @flagDate = ""
      @flagTitle = ""
    end
    # flash[:notice] = "#{@x}"
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def updatenew
    @pop = []
    @movies = Movie.all
    
    @movies.each do |m|
      @pop << m.title
    end
    
  end
  
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
