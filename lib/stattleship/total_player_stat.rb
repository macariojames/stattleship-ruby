module Stattleship
  class TotalPlayerStat < Stattleship::Endpoint
    def to_sentence
      "#{player.name} has #{total} #{stat}"
    end

    def self.fetch(path:, params:)
      super.first
    end

    def populate
      populate_players(total_player_stat)
      populate_player_teams(total_player_stat)
      total_player_stat
    end
  end

  module TotalPlayerStatRepresenter
    include Roar::JSON

    property :total_player_stat, class: Stattleship::TotalPlayerStat do
      property :player_id
      property :stat
      property :total, type: BigDecimal
    end

    collection :players, extend: Stattleship::Models::PlayerRepresenter,
                         class: Stattleship::Models::Player
    collection :teams, extend: Stattleship::Models::TeamRepresenter,
                       class: Stattleship::Models::Team
  end
end
