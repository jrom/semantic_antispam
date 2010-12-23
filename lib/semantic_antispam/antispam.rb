module Semantic
  module Antispam

    def self.included(base)
      base.extend ClassMethods
    end

    def self.config_file=(file)
      @config_file = file
    end

    def self.config_file
      @config_file || (defined?(Rails) ? Rails.root + 'config/antispam.yml' : nil)
    end

    def self.load_file
      YAML.load_file config_file
    end

    def self.hash(value)
      Digest::SHA1.hexdigest value
    end

    def self.questions
      @questions ||= load_file.collect { |e| { :question => e.keys.first, :answer => e.values.first, :hash => hash(e.keys.first) } }
    end

    def self.find(hash)
      questions.select { |q| q[:hash] == hash }.first
    end

    module ClassMethods
      def semantic_antispam
        class_eval do
          attr_writer :antispam_hash, :antispam_answer
          attr_reader :antispam_answer

          private
          def semantic_antispam_question
            @semantic_antispam_question ||= Semantic::Antispam.questions.sample
          end

          public
          def antispam_question
            semantic_antispam_question[:question]
          end

          def antispam_hash
            @antispam_hash || semantic_antispam_question[:hash]
          end

          validate :check_semantic_antispam, :on => :create
          private
          def check_semantic_antispam
            errors.add :antispam_answer, I18n.t("semantic_antispam.error_msg", :default=>"SPAM") unless antispam_answer and Semantic::Antispam.find(antispam_hash)[:answer].downcase == antispam_answer.downcase
          end
        end
      end
    end

  end
end

ActiveRecord::Base.send :include, Semantic::Antispam
