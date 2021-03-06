require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe '#library' do
  before { init_lastfm }

  it 'should return an instance of Lastfm::Library' do
    expect(@lastfm.library).to be_an_instance_of(Lastfm::MethodCategory::Library)
  end

  describe '#get_tracks' do
    it 'should get the tracks\' info' do
      expect(@lastfm).to receive(:request).with('library.getTracks', {
        :user => 'test',
        :artist => 'foo',
        :album => 'bar',
        :limit => nil,
        :page => nil
      }).and_return(make_response('library_get_tracks'))
      tracks = @lastfm.library.get_tracks(:user => 'test', :artist => 'foo', :album => 'bar')
      expect(tracks[0]['name']).to eq('Learning to Live')
      expect(tracks.size).to eq(1)
    end
  end

  describe '#get_artists' do
    it 'should get the artists\' info' do
      expect(@lastfm).to receive(:request).with('library.getArtists', {
        :user => 'test',
        :limit => nil,
        :page => nil
      }).and_return(make_response('library_get_artists'))
      artists = @lastfm.library.get_artists(:user => 'test')
      expect(artists[1]['name']).to eq('Dark Castle')
      expect(artists.size).to eq(2)
    end
  end
end
