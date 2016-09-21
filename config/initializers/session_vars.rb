CURRENT_SEASON    = Setting.find_by_name("current_season").try(:value) || "2016"
CURRENT_ROUND     = Setting.find_by_name("current_round").try(:value) || "1"