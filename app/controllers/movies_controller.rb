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
    @selected_ratings = params[:ratings]
    @flagDate = ""
    @flagTitle = ""
    @all_ratings = ['G','PG','PG-13','R','NC-17']
    #####################Filtering out Movies -Task 4#####################
    if (@selected_ratings ==nil)
      @movies = Movie.all.order(x)
    else
      @movies = Movie.all.order(x).where(rating: @selected_ratings.keys)
    end
    #####################################################################
    
    
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

  def updatenew1
    @pop = []
    @movies = Movie.all
    
    @movies.each do |m|
      @pop << m.title
    end
  end
  
  def updatenew2

    @movie = Movie.find_by_title(movie_params[:title])
    @movie.update_attributes!(movie_params)
    redirect_to movies_path
    flash[:notice] = "#{@movie.title} updated."
    
  end
  
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  def deletenew1
    @pop = []
    @movies = Movie.all
    
    @movies.each do |m|
      @pop << m.title
    end
  end
  
  def deletenewTitle
    @movie = Movie.find_by_title(movie_params[:title])
    @movie.destroy
    redirect_to movies_path
    flash[:notice] = "Movie '#{@movie.title}' deleted."
  end
    
  def deletenewRating
    x = []
    
    x = Movie.find_by_rating(movie_params[:rating])
    # @movie.destroy
    
    @allstuff = Movie.all
    @allstuff.each do |n|
      if n.rating == 'G'
        n.destroy
      end
    end
    
    redirect_to movies_path
    flash[:notice] = "All movies of rating #{x} are deleted."
  end
end
    
    # if form.submit == 'Delete Title'
    #   @movie = Movie.find_by_title(movie_params[:title])
    #   @movie.destroy
    #   redirect_to movies_path
    #   flash[:notice] = "Movie '#{@movie.title}' deleted."
    # elsif form.submit == 'Delete Rating'
    #   x = Movie.find_by_rating(movie_params[:rating])
    #   # @movie.destroy
      
    #   @allstuff = Movie.all
    #   @allstuff.each do |n| if n.rating == 'G' then n.destroy end
      
    #   redirect_to movies_path
    #   flash[:notice] = "All movies of rating '#{x}' are deleted."
    # end
    
    # if Form("submit_tag") == "titleDelete"
    #   @movie = Movie.find_by_title(movie_params[:title])
    #   @movie.destroy
    #   redirect_to movies_path
    #   flash[:notice] = "Movie '#{@movie.title}' deleted."
    # elsif Form("submit_tag") == "ratingDelete"
    #   x = Movie.find_by_rating(movie_params[:rating])
    #   # @movie.destroy
      
    #   @allstuff = Movie.all
    #   @allstuff.each do |n|
    #     if n.rating == 'G'
    #       n.destroy
    #     end 
      
    #   redirect_to movies_path
    #   flash[:notice] = "All movies of rating '#{x}' are deleted."
    # end