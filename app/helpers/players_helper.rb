module PlayersHelper

  def player_image player
    #image_tag("players/"+player.image.to_s, class: "player") if player.image
    image_tag(player.image.to_s, class: "player") if player.image
  end
end