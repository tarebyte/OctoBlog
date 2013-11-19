namespace :slug do |ns|

  desc "Generate slug for all models."
  task all: :environment do
    ns.tasks.each do |t|
      t.invoke unless t.name == "slug:all"
    end
  end

  desc "Generate slug for Repo model."
  task repo: :environment do
    create_mongoid_slug Repo
  end

  desc "Generate slug for Post model."
  task post: :environment do
    create_mongoid_slug Post
  end

  desc "Generate slug for User model."
  task user: :environment do
    create_friendly_id_slug User
  end

end

# Helpers
def print_message(model)
  puts "Generating slug for #{model.name}."
end

def create_mongoid_slug(model)
  print_message model
  model.all.each do |doc|
    doc.send :set_slug
    doc.save
  end
end

def create_friendly_id_slug(model)
  print_message model
  model.find_each(&:save)
end
