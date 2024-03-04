#!/usr/bin/env ruby
# frozen_string_literal: true

# require 'ruby_swagger'
require_relative '../lib/generate.rb'

swagger = Swagger::Generate.new do
  version '3.0.0'

  info do
    title 'Swagger Petstore'
    description 'This is a sample server Petstore server.'
    version '1.0.0'
  end

  server do
    url 'http://petstore.swagger.io/v1'
    description 'Petstore server'
  end

  server do
    url 'http://petstore.swagger.io/v1'
    description 'Petstore server'
  end

  paths do
    path '/pets/{color}' do
      get do
        summary 'List all pets'
        description 'Extended description'
        parameter do
          name 'limit'
          found_in 'query'
          description 'How many items to return at one time (max 100)'
          required false
          param_schema do
            type 'integer'
            type_format 'int32'
            minimum 0
            maximum 100
          end
        end
        parameter do
          name 'color'
          found_in 'path'
          description 'How many items to return at one time (max 100)'
          required true
          param_schema do
            type 'string'
            enum ['blue', 'green', 'red']
          end
        end
        parameter do
          name 'west'
          found_in 'query'
          description 'Opposite of east'
          required false
          param_schema do
            type 'array'
            items 'type' => 'string'
          end
        end
        parameter do
          name 'east'
          found_in 'query'
          description 'Opposite of west'
          required false
          param_schema do
            type 'boolean'
          end
          allow_empty_value true 
        end
        responses do
          response 200 do
            description 'A paged array of pets'
            content 'application/json' do
              schema 'Success'
            end
          end
          response 500 do
            description 'unexpected error'
            content 'application/json' do
              schema 'Error/500'
            end
          end
        end
      end

      post do
        summary 'List all pets'
        description 'Extended description'
        request_body 'SomeRequestBody'
        parameter do
          name 'limit'
          found_in 'query'
          description 'How many items to return at one time (max 100)'
          required false
          param_schema do
            type 'integer'
            type_format 'int32'
            minimum 0
            maximum 100
          end
        end
        parameter do
          name 'color'
          found_in 'path'
          description 'How many items to return at one time (max 100)'
          required true
          param_schema do
            type 'string'
            enum ['blue', 'green', 'red']
          end
        end
        parameter do
          name 'west'
          found_in 'query'
          description 'Opposite of east'
          required false
          param_schema do
            type 'array'
            items 'type' => 'string'
          end
        end
        parameter do
          name 'east'
          found_in 'query'
          description 'Opposite of west'
          required false
          param_schema do
            type 'boolean'
          end
          allow_empty_value true 
        end
        responses do
          response 200 do
            description 'A paged array of pets'
            content 'application/json' do
              schema 'Success'
            end
          end
          response 500 do
            description 'unexpected error'
            content 'application/json' do
              schema 'Error/500'
            end
          end
        end
      end
    end
    path '/pets/{age}' do
      get do
        summary 'List all pets ages'
        description 'Extended description'
        parameter do
          name 'limit'
          found_in 'query'
          description 'How many items to return at one time (max 100)'
          required false
          param_schema do
            type 'integer'
            type_format 'int32'
            minimum 0
            maximum 100
          end
        end
        parameter do
          name 'age'
          found_in 'path'
          description 'How many items to return at one time (max 100)'
          required true
          param_schema do
            type 'string'
            enum ['blue', 'green', 'red']
          end
        end
        parameter do
          name 'west'
          found_in 'query'
          description 'Opposite of east'
          required false
          param_schema do
            type 'array'
            items 'type' => 'string'
          end
        end
        parameter do
          name 'east'
          found_in 'query'
          description 'Opposite of west'
          required false
          param_schema do
            type 'boolean'
          end
          allow_empty_value true 
        end
        responses do
          response 200 do
            description 'A paged array of pets'
            content 'application/json' do
              schema 'Success'
            end
          end
          response 500 do
            description 'unexpected error'
            content 'application/json' do
              schema 'Error/500'
            end
          end
        end
      end

      post do
        summary 'List all pets'
        description 'Extended description'
        request_body 'SomeRequestBody'
        parameter do
          name 'limit'
          found_in 'query'
          description 'How many items to return at one time (max 100)'
          required false
          param_schema do
            type 'integer'
            type_format 'int32'
            minimum 0
            maximum 100
          end
        end
        parameter do
          name 'color'
          found_in 'path'
          description 'How many items to return at one time (max 100)'
          required true
          param_schema do
            type 'string'
            enum ['blue', 'green', 'red']
          end
        end
        parameter do
          name 'west'
          found_in 'query'
          description 'Opposite of east'
          required false
          param_schema do
            type 'array'
            items 'type' => 'string'
          end
        end
        parameter do
          name 'east'
          found_in 'query'
          description 'Opposite of west'
          required false
          param_schema do
            type 'boolean'
          end
          allow_empty_value true 
        end
        responses do
          response 200 do
            description 'A paged array of pets'
            content 'application/json' do
              schema 'Success'
            end
          end
          response 500 do
            description 'unexpected error'
            content 'application/json' do
              schema 'Error/500'
            end
          end
        end
      end
    end
  end


end

puts swagger.doc.to_yaml