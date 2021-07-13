require 'rails_helper'

RSpec.describe ImdbService do
  describe 'class methods' do
    describe '.top_movies_search' do
      it 'returns an array based on search' do
        VCR.use_cassette 'imdb_search' do
          actual = ImdbService.top_movies_search('Jack')

          expect(actual.class).to eq(Array)
          expect(actual[0].title.include?('Jack')).to eq(true)
          expect(actual[0].title.nil?).to eq(false)
          expect(actual[0].class).to eq(Movie)
          expect(actual.count).to eq(40)
        end
      end
      it 'returns No Movies Found if not title matches' do
        VCR.use_cassette 'imdb_nil' do
          actual = ImdbService.top_movies_search('klsdjfl')

          expect(actual).to eq('No Movies Found')
        end
      end
    end
    describe '.top_movies' do
      it 'returns an array containing the top movies titles and vote average' do
        VCR.use_cassette 'imdb_top' do
          actual = ImdbService.top_movies

          expect(actual.class).to eq(Array)
          expect(actual[0].title.include?('Tomorrow')).to eq(true)
          expect(actual[0].title.nil?).to eq(false)
          expect(actual[0].class).to eq(Movie)
          expect(actual.count).to eq(40)
        end
      end
    end
    describe '.movie_data' do
      it 'returns a set of data for a specific movie' do
        VCR.use_cassette 'imdb_jack_data' do
          actual = ImdbService.movie_data(75780)

          expect(actual.class).to eq(Hash)
          expect(actual[:title]).to eq("Jack Reacher")
          expect(actual[:vote_average]).to eq(6.5)
          expect(actual[:runtime]).to eq(130)
          expect(actual[:genres][0][:name]).to eq('Crime')
          expect(actual[:overview]).to eq("When a gunman takes five lives with six shots, all evidence points to the suspect in custody. On interrogation, the suspect offers up a single note: \"Get Jack Reacher!\" So begins an extraordinary chase for the truth, pitting Jack Reacher against an unexpected enemy, with a skill for violence and a secret to keep.")
          expect(actual[:vote_count]).to eq(5308)
        end
      end
    end
    describe '.movie_cast' do
      it 'returns an array of up to ten actors who worked on the movie' do
        VCR.use_cassette 'imdb_jack_cast' do
          actual = ImdbService.movie_cast(75780)

          expect(actual.class).to eq(Array)
          expect(actual.length).to eq(10)
          expect(actual[0]).to eq('Tom Cruise')
          expect(actual[9]).to eq('Josh Helman') 
        end
      end
    end
    describe '.movie_reviews' do
      it 'returns names of reviewers and their reviews' do
        VCR.use_cassette 'imdb_jack_reviews' do
          actual = ImdbService.movie_reviews(75780)

          expect(actual.class).to eq(Array)
          expect(actual[0].class).to eq(Hash)
          expect(actual[0][:name]).to eq('Kenneth Axel Carlsson')
          expect(actual.last[:name]).to eq('John Chard')
          expect(actual[0][:review].class).to eq(String)
        end
      end
    end
  end
end