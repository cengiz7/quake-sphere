namespace :data_sources do
  desc "Seed genres for data sources"
  task seed_genres: :environment do
    DataSource.find_or_create_by!(
      slug: "system",
      url: "",
      name: "System",
      description: "Internal System"
    )

    DataSource.find_or_create_by!(
      slug: "boun_edu",
      url: "http://www.koeri.boun.edu.tr/scripts/lasteq.asp",
      name: "Boğaziçi University, Kandilli Observatory And Earthquake Research Institute",
      description: "Boğaziçi University," +
                   "Kandilli Observatory And Earthquake Research Institute" +
                   "34684 Çengelköy-İstanbul/TÜRKİYE"
    )
  end

end