class MoviesController < ApplicationController
  
  def index
    @movies = Movie.where(nil).page(params[:page]).per(5)
    @movies = @movies.by_title(params[:title]) if params[:title].present?
    @movies = @movies.by_director(params[:director]) if params[:director].present?
    case params[:duration]
    when 'Under 90 minutes'
      limit1 = 0
      limit2 = 89
    when 'Between 90 and 120 min'
      limit1 = 90
      limit2 = 120
    when 'Over 120 min'
      limit1 = 121
      limit2 = 9999   
    end
    @movies = @movies.by_duration(limit1, limit2) if params[:duration].present?
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :image
    )
  end

end