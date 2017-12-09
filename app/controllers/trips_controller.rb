class TripsController < ApplicationController

  get '/trips/new' do
   if logged_in?
    @user = current_user
    erb :'/trips/new'
   else
    redirect "/login"
  end
 end

 post '/trips' do
  @user = current_user
  if params[:date] == ""
   redirect "/trips/new"
  else
   @trip = Trip.create(name: params[:name], location: params[:location], site: params[:site], date: params[:date], summary: params[:summary])
   @trip.user_id = @user.id
   @trip.save
   redirect "/trips/#{@trip.id}"
  end
 end

 get '/trips' do
   if logged_in?
    @user = current_user
    @trips = Trip.all
    erb :'/trips/trips'
   else
    redirect "/login"
   end
  end

  get '/trips/:id' do
   if logged_in?
    @trip = Trip.find(params[:id])
    @camper = User.find(@trip.user_id)
    erb :'trips/show'
   else
    redirect "/login"
   end
  end

  post '/trips/:id/edit' do
   @trip = Trip.find(params[:id])
   if logged_in? && @trip.user_id == current_user.id
    erb :'trips/edit'
   else
    redirect "/login"
   end
  end

  post '/trips/:id' do
   @trip = Trip.find(params[:id])
   if params[:summary] == ""
    redirect "/trips/#{params[:id]}/edit"
   else
    @trip.update(name: params[:name], location: params[:location], site: params[:site], date: params[:date], summary: params[:summary])
    redirect "/trips/#{params[:id]}"
   end
  end

  post '/trips/:id/delete' do
   @trip = Trip.find(params[:id])
   @user = current_user
   if logged_in? && @trip.user_id == @user.id
    @trip.delete
    erb :'/trips/delete'
   else
    redirect "/login"
   end
  end

end
