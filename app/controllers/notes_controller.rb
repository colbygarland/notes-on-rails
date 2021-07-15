class NotesController < ApplicationController
  def index
    @notes = Note.order(updated_at: :desc)
  end

  def show
    @note = Note.find(params[:id])
  end

  def new
    @note = Note.new
  end

  def create 
    @note = Note.new(note_params)

    if @note.save 
      redirect_to @note 
    else 
      render :new 
    end
  end

  def edit 
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])

    if @note.update(note_params) 
      redirect_to @note 
    else 
      render :edit 
    end
  end

  def destroy
    @note = Note.find(params[:id])

    # Remove the note's comments if it has any
    @note.comments.all.each do |comment| 
      comment.destroy
    end

    @note.destroy

    redirect_to root_path
  end

  private 
    def note_params
      params.require(:note).permit(:title, :body)
    end
end
