class Authenticated::MoviePartyController < Authenticated::BaseController

  def new
    @title = params[:title]
    @movie_length = params[:runtime]

    @friends = current_user.friends_list
  end

  def create
    date_time = DateTime.parse(params[:date]+" "+params[:time])
    party = MovieParty.create({user: current_user, movie_title: params[:title], date_time: date_time, runtime: params[:duration]})
    params[:friend].each do |friend_id| 
      friend = User.find(friend_id.to_i)
      Attendee.create({movie_party: party, user: friend})
      InviteMailer.invite_email(host: current_user, party: party, user: friend).deliver_later
    end unless !params[:friend]

    redirect_to '/dashboard'
  end
end
