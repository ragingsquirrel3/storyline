require 'csv'

class ScenesController < ApplicationController
  def index
    @story = Story.find(params[:story_id])
    #render json: @story.scenes
    @scene = @story.scenes.build
  end
  
  def show
  end
  
  def create
    @story = Story.find(params[:story_id])
    
    respond_to do |format|
      if @story.add_scene(params[:scene])
        format.html { redirect_to story_scenes_path, story_id: @story.id, notice: 'Scene was successfully created.' }
        format.json { render json: @story, status: :created, location: @story }
      else
        format.html { render action: "index" }
        format.json { render json: @scene.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
  end
  
  def destroy
  end
end
