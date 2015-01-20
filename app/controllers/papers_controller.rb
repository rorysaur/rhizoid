# encoding: utf-8

class PapersController < ApplicationController
  def new
    @paper = Paper.new
  end

  def create
    @paper = Paper.new(paper_params)

    # parse pdf
    pdf = Paperclip.io_adapters.for(@paper.file)
    hypdf_response_text = HyPDF.pdftotext(pdf.path)[:text]

    # filter out non-ascii characters
    encoding_options = {
      :invalid           => :replace,  # Replace invalid byte sequences
      :undef             => :replace,  # Replace anything not defined in ASCII
      :replace           => '',        # Use a blank for those replacements
      :universal_newline => true       # Always break lines with \n
    }
    @paper.text = hypdf_response_text.encode(Encoding.find('ASCII'), encoding_options)

    if @paper.save
      render :json => { :paper => @paper }, :status => 201
    else
      render :json => { :errors => @paper.errors }, :status => 422
    end
  end

  def show
    @paper = Paper.find(params[:id])
    render :show
  end

  private

  def paper_params
    params.require(:paper).permit(:title, :author_name, :year, :text, :file)
  end
end
