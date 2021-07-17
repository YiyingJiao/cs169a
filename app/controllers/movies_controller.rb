class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings=Movie.all_ratings
    @ratings_to_show = []
    @ratings_forsession={}
    if params['ratings'] != nil
      session['ratings']=params['ratings']
    end
    if session['ratings']!= nil 
      ratings = session['ratings'].keys
    end
    if ratings != nil
      @ratings_forsession = session['ratings']
      @ratings_to_show = ratings
    end
    @movies = Movie.with_ratings(ratings)
      
    if params['sort_option'] != nil
      session['sort_option'] = params['sort_option']
    @sort_option = session['sort_option']
    end
    if @sort_option != nil
      @movies=@movies.sort_by{ |list|
        list[@sort_option]
      }
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

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
