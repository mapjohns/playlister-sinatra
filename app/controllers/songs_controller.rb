class SongsController < ApplicationController

    get '/songs' do
        @songs = Song.all
        erb :'/songs/index'
    end

    get '/songs/new' do
        @genres = Genre.all
        @artists = Artist.all
        erb :'/songs/new'
    end

    post '/songs' do
        @song = Song.create(params[:song])
        # @song.artist = params[:artist]
        if !params[:artist].empty?
            if Artist.find_by(name: params[:artist][:name])
                @song.artist = Artist.find_by(name: params[:artist][:name])
            else
                artist = Artist.create(params[:artist])
                @song.artist = artist
            end
        end

        if !params[:genres].empty?
            params[:genres].each do |genre|
                @song.genres << Genre.find(genre)
            end
        end
        @song.save
        flash[:message] = "Successfully created song."
        redirect "/songs/#{@song.slug}"
    end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :'/songs/show'
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        @genres = Genre.all
        @artists = Artist.all
        erb :'/songs/edit'
    end

    patch '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        @song.update(params[:song])
        if !params[:artist].empty?
            if Artist.find_by(name: params[:artist][:name])
                @song.artist = Artist.find_by(name: params[:artist][:name])
            else
                artist = Artist.create(params[:artist])
                @song.artist = artist
            end
        end
        @song.save
        flash[:message] = "Successfully updated song."

        redirect "/songs/#{@song.slug}"

    end
end
