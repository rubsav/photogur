class PicturesController < ApplicationController

	def index
		@most_recent_pictures = Picture.most_recent_five
        @older_pictures = Picture.created_before(0.day.ago)
		@pictures = Picture.all
	end

	def show
		@picture = Picture.find(params[:id])
	end

# def new
# end

# def create
# render :text => "Saving a picture. URL: #{params[:url]}, Title: #{params[:title]}, Artist: #{params[:artist]}"
# end

	def new
		@picture = Picture.new
	end

	def create
	# make a new picture with what picture_params returns (which is a method we're calling)
		@picture = Picture.new(picture_params)
			if @picture.save
	# if the save for the picture was successful, go to index.html.erb
	redirect_to pictures_url
			else
	# otherwise render the view associated with the action :new (i.e. new.html.erb)
			render :new
		end
	end

	def edit
    	@picture = Picture.find(params[:id])
  	end

  	def update
   		@picture = Picture.find(params[:id])
			if @picture.update_attributes(picture_params)
				redirect_to "/pictures/#{@picture.id}"
    		else
    			render :edit
    		end
  	end

  	def destroy
	    @picture = Picture.find(params[:id])
	    @picture.destroy
	    redirect_to pictures_url
  	end

private
	def picture_params
		params.require(:picture).permit(:artist, :title, :url)
	end



end