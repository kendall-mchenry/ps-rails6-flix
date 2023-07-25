class ReviewsController < ApplicationController

  before_action :set_movie

  def index
    @reviews = @movie.reviews
  end

  def new
    @review = @movie.reviews.new
  end

  def edit
    @review = @movie.reviews.find(params[:id])
  end

  def create
    @review = @movie.reviews.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to movie_reviews_path(@movie), notice: "Thanks for your review!" }
        # format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @review = @movie.reviews.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to movie_reviews_path, alert: "Review successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:name, :comment, :stars)
  end
end
