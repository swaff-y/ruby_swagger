# frozen_string_literal: true

require 'json'
require 'yaml'
require 'bury'

module Swagger
  class Generate
    attr_accessor :doc

    def initialize(&block)
      @doc = {}
      @attributes = { doc: @doc }
      instance_eval(&block) if block_given?
    end

    def version(version = nil)
      version = '3.0.0' if version.nil?

      @doc.bury!(%w[openapi], version)

      version
    end

    def info(&block)
      @doc['info'] = Info.new(&block).attributes
    end

    def server(&block)
      return @doc['servers'] << Server.new(&block).attributes if @doc['servers']
      @doc['servers'] = [Server.new(&block).attributes]
    end

    def paths(&block)
      @attributes[:dir] = %w[paths]
      Paths.new(@attributes, &block)
    end
  end

  class Info
    attr_accessor :title, :description, :version

    def initialize(&block)
      instance_eval(&block)
    end

    def title(value = nil)
      @title = value if value
      @title
    end

    def description(value = nil)
      @description = value if value
      @description
    end

    def version(value = nil)
      @version = value if value
      @version
    end

    def attributes
      { 'title' => title, 'description' => description, 'version' => version }
    end
  end

  class Server
    attr_accessor :url, :description

    def initialize(&block)
      instance_eval(&block)
    end

    def url(value = nil)
      @url = value if value
      @url
    end

    def description(value = nil)
      @description = value if value
      @description
    end

    def attributes
      { 'url' => url, 'description' => description }
    end
  end

  class Paths
    def initialize(attributes, &block)
      @attributes = attributes
      instance_eval(&block) if block_given?
    end

    def path(path, &block)
      @attributes[:dir].pop(3) if @attributes[:dir].last != 'paths'
      @attributes[:dir] << path

      Path.new(@attributes, &block)
    end
  end

  class Path
    def initialize(attributes, &block)
      @attributes = attributes
      instance_eval(&block) if block_given?
    end

    def get(&block)
      @attributes[:dir].pop(2) if @attributes[:dir].last == 'parameters'
      @attributes[:dir] << 'get'

      Get.new(@attributes, &block)
    end

    def post(&block)
      @attributes[:dir].pop(2) if @attributes[:dir].last == 'parameters'
      @attributes[:dir] << 'post'

      Post.new(@attributes, &block)
    end

    def patch(&block)
      @attributes[:dir].pop(2) if @attributes[:dir].last == 'parameters'
      @attributes[:dir] << 'patch'

      Patch.new(@attributes, &block)
    end

    def put(&block)
      @attributes[:dir].pop(2) if @attributes[:dir].last == 'parameters'
      @attributes[:dir] << 'patch'

      Put.new(@attributes, &block)
    end

    def delete(&block)
      @attributes[:dir].pop(2) if @attributes[:dir].last == 'parameters'
      @attributes[:dir] << 'delete'

      Delete.new(@attributes, &block)
    end
  end

  class Get
    attr_accessor :summary, :description

    def initialize(attributes, &block)
      @attributes = attributes
      instance_eval(&block) if block_given?
    end

    def parameter(&block)
      dir = @attributes[:dir].dup
      @attributes[:doc].bury!(dir, attributes) if dir.last == 'get'
      @attributes[:dir] << 'parameters' if @attributes[:dir].last != 'parameters'
      Parameter.new(@attributes, &block)
    end

    def responses(&block)
      dir = @attributes[:dir].dup
      dir.pop if dir.last == 'parameters'
      dir << 'responses'
      @attributes[:dir_responses] = dir
      Responses.new(@attributes, &block)
    end

    #set in the calling class
    def summary(value = nil)
      @summary = value if value
      @summary
    end

    def description(value = nil)
      @description = value if value
      @description
    end

    def attributes
      { 
        'summary' => summary,
        'description' => description
      }
    end
  end

  class Post
    attr_accessor :summary, :description

    def initialize(attributes, &block)
      @attributes = attributes
      instance_eval(&block) if block_given?
    end

    def parameter(&block)
      dir = @attributes[:dir].dup
      @attributes[:doc].bury!(dir, attributes) if dir.last == 'post'
      @attributes[:dir] << 'parameters' if @attributes[:dir].last != 'parameters'
      Parameter.new(@attributes, &block)
    end

    def responses(&block)
      dir = @attributes[:dir].dup
      dir.pop if dir.last == 'parameters'
      dir << 'responses'
      @attributes[:dir_responses] = dir
      Responses.new(@attributes, &block)
    end

    #set in the calling class
    def summary(value = nil)
      @summary = value if value
      @summary
    end

    def description(value = nil)
      @description = value if value
      @description
    end

    def request_body(value = nil)
      @request_body = value if value
      @request_body
    end

    def attributes
      { 
        'summary' => summary,
        'description' => description,
        'requestBody' => { 
          '$ref' => "#/components/requestBodies/#{request_body}"
        }
      }
    end
  end

  class Patch
    attr_accessor :summary, :description

    def initialize(attributes, &block)
      @attributes = attributes
      instance_eval(&block) if block_given?
    end

    def parameter(&block)
      dir = @attributes[:dir].dup
      @attributes[:doc].bury!(dir, attributes) if dir.last == 'patch'
      @attributes[:dir] << 'parameters' if @attributes[:dir].last != 'parameters'
      Parameter.new(@attributes, &block)
    end

    def responses(&block)
      dir = @attributes[:dir].dup
      dir.pop if dir.last == 'parameters'
      dir << 'responses'
      @attributes[:dir_responses] = dir
      Responses.new(@attributes, &block)
    end

    #set in the calling class
    def summary(value = nil)
      @summary = value if value
      @summary
    end

    def description(value = nil)
      @description = value if value
      @description
    end

    def request_body(value = nil)
      @request_body = value if value
      @request_body
    end

    def attributes
      { 
        'summary' => summary,
        'description' => description,
        'requestBody' => { 
          '$ref' => "#/components/requestBodies/#{request_body}"
        }
      }
    end
  end

  class Put
    attr_accessor :summary, :description

    def initialize(attributes, &block)
      @attributes = attributes
      instance_eval(&block) if block_given?
    end

    def parameter(&block)
      dir = @attributes[:dir].dup
      @attributes[:doc].bury!(dir, attributes) if dir.last == 'put'
      @attributes[:dir] << 'parameters' if @attributes[:dir].last != 'parameters'
      Parameter.new(@attributes, &block)
    end

    def responses(&block)
      dir = @attributes[:dir].dup
      dir.pop if dir.last == 'parameters'
      dir << 'responses'
      @attributes[:dir_responses] = dir
      Responses.new(@attributes, &block)
    end

    #set in the calling class
    def summary(value = nil)
      @summary = value if value
      @summary
    end

    def description(value = nil)
      @description = value if value
      @description
    end

    def request_body(value = nil)
      @request_body = value if value
      @request_body
    end

    def attributes
      { 
        'summary' => summary,
        'description' => description,
        'requestBody' => { 
          '$ref' => "#/components/requestBodies/#{request_body}"
        }
      }
    end
  end

  class Delete
    attr_accessor :summary, :description

    def initialize(attributes, &block)
      @attributes = attributes
      instance_eval(&block) if block_given?
    end

    def parameter(&block)
      dir = @attributes[:dir].dup
      @attributes[:doc].bury!(dir, attributes) if dir.last == 'delete'
      @attributes[:dir] << 'parameters' if @attributes[:dir].last != 'parameters'
      Parameter.new(@attributes, &block)
    end

    def responses(&block)
      dir = @attributes[:dir].dup
      dir.pop if dir.last == 'parameters'
      dir << 'responses'
      @attributes[:dir_responses] = dir
      Responses.new(@attributes, &block)
    end

    #set in the calling class
    def summary(value = nil)
      @summary = value if value
      @summary
    end

    def description(value = nil)
      @description = value if value
      @description
    end

    def request_body(value = nil)
      @request_body = value if value
      @request_body
    end

    def attributes
      { 
        'summary' => summary,
        'description' => description,
        'requestBody' => { 
          '$ref' => "#/components/requestBodies/#{request_body}"
        }
      }
    end
  end

  class Parameter
    attr_accessor :name, :in, :description, :required, :schema

    def initialize(attributes, &block)
      @attributes = attributes
      instance_eval(&block) if block_given?
    end

    def param_schema(&block)
      dir = @attributes[:dir].dup
      @attributes[:doc].dig(*dir) << attributes if @attributes[:doc].dig(*dir).is_a?(Array)
      @attributes[:doc].bury!(dir, [attributes]) if @attributes[:doc].dig(*dir).nil?
      Schema.new(@attributes, &block)
    end

    # set in the calling class
    def name(value = nil)
      @name = value if value
      @name
    end

    def found_in(value = nil)
      @in = value if value
      @in
    end

    def description(value = nil)
      @description = value if value
      @description
    end

    def required(value = nil)
      @required = value if value
      @required
    end

    def allow_empty_value(value = nil)
      @allow_empty_value = value if value
      @allow_empty_value
    end

    def attributes
      { 
        'name' => name,
        'description' => description,
        'in' => found_in,
        'required' => required ? 'true' : 'false',
        'allowEmptyValue' => allow_empty_value ? 'true' : 'false'
      }
    end
  end

  class Responses
    def initialize(attributes, &block)
      @attributes = attributes
      instance_eval(&block) if block_given?
    end

    def response(code, &block)
      dir = @attributes[:dir_responses].dup
      @attributes[:dir_responses].pop(3) if dir.last != 'responses'
      @attributes[:dir_responses] << code
      Response.new(@attributes, &block)
    end
  end

  class Response
    attr_accessor :description

    def initialize(attributes, &block)
      @attributes = attributes
      instance_eval(&block) if block_given?
    end

    def content(type, &block)
      dir = @attributes[:dir_responses].dup
      @attributes[:doc].bury!(dir, content_attributes)
      @attributes[:dir_responses] << 'content'
      @attributes[:dir_responses] << type
      Content.new(@attributes, &block)
    end

    def description(value = nil)
      @description = value if value
      @description
    end

    def content_attributes
      { 'description' => description }
    end
  end

  class Schema
    attr_accessor :type, :format, :items

    def initialize(attributes, &block)
      @attributes = attributes
      instance_eval(&block) if block_given?
      dir = @attributes[:dir].dup
      @attributes[:doc].dig(*dir).last['schema'] = schema_attributes
    end
    
    # set in the calling class
    def type(value = nil)
      @type = value if value
      @type
    end

    def type_format(value = nil)
      @format = value if value
      @format
    end

    def items(value = nil)
      @items = value if value
      @items
    end

    def enum(value = nil)
      @enum = value if value
      @enum
    end

    def minimum(value = nil)
      @minimum = value if value
      @minimum
    end

    def maximum(value = nil)
      @maximum = value if value
      @maximum
    end

    def schema_attributes
      schema = { 'type' => type }
        schema.merge! 'format' => type_format unless type_format.nil?
        schema.merge! 'items' => items unless items.nil?
        schema.merge! 'enum' => enum unless enum.nil?
        schema.merge! 'minimum' => minimum unless minimum.nil?
        schema.merge! 'maximum' => maximum unless maximum.nil?
        schema
    end
  end

  class Content
    def initialize(attributes, &block)
      @attributes = attributes
      instance_eval(&block) if block_given?
    end

    def schema(schema, &block)
      dir = @attributes[:dir_responses].dup
      dir << 'schema'
      dir << '$ref'
      @attributes[:doc].bury!(dir, "#/components/schemas/#{schema}")
    end
  end
end