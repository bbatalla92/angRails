class EntriesController < ApplicationController
    respond_to :json
    protect_from_forgery

    def index
        respond_with Entry.all
    end

    def show
        respond_with Entry.find(params[:id])
    end

    def create
        @entry = Entry.new(entry_params)
        @entry.save
        respond_with(@entry)
    end

    def update
        respond_with Entry.update(params[:id], params[entry])
    end

    def destroy
        respond_with Entry.destroy(params[:id])
    end


    def entry_params
      params.require(:entry).permit(:name, :createdAt)
    end

end
