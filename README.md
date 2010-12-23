# Semantic Antispam

Simple semantic antispam solution for ActiveRecord-based applications.

Define questions and answers in a YAML file and validate your models with a single line of code. No more captchas or other stupid tricks.

## Installation

Add the dependency to your `Gemfile`

    gem 'semantic_antispam'

Create a questions file at `config/antispam.yml` with the following format:

    - Color of the sea?: blue
    - Color of the sky?: blue
    - Capital of France?: paris

If you are not using Rails or want to save this file in a different location:

    # config/application.rb if this is a Rails app
    
    Semantic::Antispam.config_file = Rails.root + '/antispam.yml'

You can also customize the validation error message by adding a key to your translations file:

    semantic_antispam:
      error_msg: "I'm not sure you're human. I'll give you another chance, please answer the question again."

## Usage

If you want to check the humanness of your commenters, just modify your `Comment` model:

    class Comment < ActiveRecord::Base
      semantic_antispam
    end

And add this code in your comment form:

    <%= f.hidden_field :antispam_hash %>
    <%= f.label :antispam_answer, f.object.antispam_question %>
    <%= f.text_field :antispam_answer %>

## Contributing

If you want to improve semantic_antispam

1. Fork the repo
2. Create a topic branch `git checkout -b my_feature`
3. Push it! `git push origin my_feature`
4. Open a pull request

## Issues

<http://github.com/jrom/semantic_antispam/issues>
