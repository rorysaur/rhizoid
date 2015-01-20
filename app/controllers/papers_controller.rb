class PapersController < ApplicationController

  def new
    @paper = Paper.new
  end

  def create
    @paper = Paper.new(paper_params)
    @paper.text = "meow meow meow"
    if @paper.save
      render :json => { :paper => @paper }, :status => 201
    else
      render :json => { :errors => @paper.errors }, :status => 422
    end
  end

  private

  def paper_params
    params.require(:paper).permit(:title, :author_name, :year, :text, :file)
  end
end
