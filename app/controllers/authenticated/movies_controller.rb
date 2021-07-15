class Authenticated::MoviesController < Authenticated::BaseController

  def index
    @movie_search = MovieFacade.top_movie_search_results(params[:movie_title])
  end

  def show
    @movie = MovieFacade.movie_data_results(params[:id])
    @cast = MovieFacade.movie_cast_results(params[:id])
    @reviews = MovieFacade.movie_review_results(params[:id])
  end
end
