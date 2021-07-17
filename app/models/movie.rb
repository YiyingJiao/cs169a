class Movie < ActiveRecord::Base
  def self.with_ratings(raitings_list)
    m_toshow=[]
    if ratings_list == nil
      return Movie.all
    end
    ratings_list.each do |r|
      m_toshow.append(Movie.where('rating=r'))
    end
    return m_toshow
  end
  @@all_ratings = ['G','PG','PG-13','R']
  def all_ratings
    @@all_ratings
  end
end
