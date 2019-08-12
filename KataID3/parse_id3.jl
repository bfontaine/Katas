#!/usr/bin/env julia

#= ID3v1.1 parser
   http://rubyquiz.com/quiz136.html

   Usage:
     ./script <mp3 file> [...]
=#

module ID3
using Printf

const tagsSize = 128

struct Tags
  song :: String
  artist :: String
  album  :: String
  year :: String
  comment :: String
  genre_index :: UInt8
  track_number :: Union{UInt8, Nothing}
end

function load_genres()
  open(joinpath(@__DIR__, "genres")) do f
    readlines(f)
  end
end

genres = load_genres()

function genre(t :: Tags) :: Union{String, Nothing}
  if 0 <= t.genre_index < length(genres)
    genres[t.genre_index+1]
  end
end

function read_tags_string(f) :: String
  seekend(f)
  offset = position(f)
  if offset >= tagsSize
    skip(f, -tagsSize)
    read(f, String)
  else
    ""
  end
end

function extract_field(tag_string :: String, interval) :: String
  string(strip(SubString(tag_string, interval), '\0'))
end

"""
Parse tags from a string and return either nothing or a Tags struct.
"""
function parse_tags(tag_string :: String) :: Union{Tags, Nothing}
  if length(tag_string) != tagsSize || SubString(tag_string, 1:3) != "TAG"
    return nothing
  end
  # 1       4     34       64      94     98       128     129
  # | "TAG" | song | artist | album | year | comment | genre |
  comment = SubString(tag_string, 98:127)
  track_number = nothing

  if comment[29] == '\0' && comment[30] != '\0'
    track_number = UInt8(comment[30])
    comment = SubString(comment, 1, 29)
  end

  Tags(
       extract_field(tag_string, 4:33),
       extract_field(tag_string, 34:63),
       extract_field(tag_string, 64:93),
       extract_field(tag_string, 94:97),
       string(strip(comment, '\0')),
       UInt8(tag_string[128]),
       track_number,
      )
end

function print_tags(filename :: String, tags :: Union{Tags, Nothing})
  @printf("%s\n", filename)
  if tags == nothing
    return println("  (no ID3 tags)")
  end
  @printf("  Song:   %s\n", tags.song)
  @printf("  Artist: %s\n", tags.artist)
  @printf("  Album:  %s\n", tags.album)
  if tags.track_number != nothing
    @printf("  Track number: %d\n", tags.track_number)
  end
  @printf("  Year:   %s\n", tags.year)
  @printf("  Genre:  %s\n", genre(tags))
  if !isempty(tags.comment)
    @printf("  Comment: %s\n", tags.comment)
  end
end

export read_tags_string, parse_tags, print_tags, load_genres, genre

end # module end

using Printf

if PROGRAM_FILE != "" && realpath(@__FILE__) == realpath(PROGRAM_FILE)
  using .ID3

  if isempty(ARGS)
    println("Usage:\n  $(PROGRAM_FILE) <mp3 file> [...]")
  else
    for filename in ARGS
      tag_string = try
        open(filename) do f
          read_tags_string(f)
        end
      catch e
        @printf(stderr, "Error reading file '%s': %s\n", filename, e)
        exit(1)
      end
      tags = parse_tags(tag_string)
      print_tags(filename, tags)
    end
  end
end
