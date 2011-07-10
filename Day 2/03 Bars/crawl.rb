crawl do

  pub :name => 'Mitre' do
    address do
      street 'Some lane'
      lng 123.21
      lat 45.34
    end

    beers do
      coopers
      asahi
      bluetongue
      carlton
      cascade
    end

    crowd :mood => :bankers

  end

  bar :name => '1806' do

    address do
      street 'Exhibition Street'
      lng 123.21
      lat 45.34
    end

    cocktails do
      appletini
      caipraroska
    end

    crowd :mood => :legends

  end

end
