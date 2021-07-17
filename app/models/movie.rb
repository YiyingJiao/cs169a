class Movie < ActiveRecord::Base
  def self.with_ratings(ratings_list)
    m_toshow=[]
    if ratings_list == nil
      return Movie.all
    end
    ratings_list.each do |r|
      m_toshow +=  Movie.where(:rating=>r)
    end
    return m_toshow
  end
  @@all_ratings = ['G','PG','PG-13','R']
  def self.all_ratings
    @@all_ratings
  end
end
