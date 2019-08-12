#!/usr/bin/env julia

using Test

include("parse_id3.jl")
using .ID3: Tags, read_tags_string, parse_tags, print_tags, load_genres, genre

@testset "read_tags_string" begin
  io = IOBuffer()
  ts = string("TAG", repeat("X", 128-3))
  write(io, ts)
  seekstart(io)
  @test read_tags_string(io) == ts

  @testset "invalid" begin
    io = IOBuffer()
    ts = string("TAG", "nope")
    write(io, ts)
    seekstart(io)
    @test read_tags_string(io) == ""
  end
end

@testset "parse_tags" begin
  @testset "invalid strings" begin
    @test parse_tags("") == nothing
    @test parse_tags("i'm not a tags string") == nothing
    @test parse_tags("TAG i'm still not a tags string") == nothing
  end
  @testset "song" begin
    only_song = string("TAGSome song", repeat("\0", 116))
    t = parse_tags(only_song)
    @test t != nothing
    @test t.song == "Some song"

    song1 = repeat("1", 30)
    @test parse_tags(string("TAG", song1, repeat("2", 128-33))).song == song1
  end
  @testset "full fields v1" begin
    song = repeat("S", 30)
    artist = repeat("A", 30)
    album = repeat("a", 30)
    year = "2019"
    comment = repeat("c", 30)
    genre_index = UInt8(42)
    s = string("TAG", song, artist, album, year, comment, Char(genre_index))
    @test length(s) == 128

    t = parse_tags(s)
    @test t != nothing
    @test t.song == song
    @test t.artist == artist
    @test t.album == album
    @test t.year == year
    @test t.comment == comment
    @test t.genre_index == genre_index
    @test t.track_number == nothing
  end

  @testset "partial fields v1" begin
    song = "hey"
    artist = "i"
    album = "just"
    year = "1999"
    comment = "met you"
    genre_index = UInt8(10)
    s = string("TAG",
               rpad(song, 30, '\0'),
               rpad(artist, 30, '\0'),
               rpad(album, 30, '\0'),
               year,
               rpad(comment, 30, '\0'),
               Char(genre_index))
    @test length(s) == 128

    t = parse_tags(s)
    @test t != nothing
    @test t.song == song
    @test t.artist == artist
    @test t.album == album
    @test t.year == year
    @test t.comment == comment
    @test t.genre_index == genre_index
    @test t.track_number == nothing
  end

  @testset "with track number (v1.1)" begin
    @testset "full comment" begin
      comment = repeat("C", 28)
      s = string("TAG", repeat("X", 30+30+30), "1984", comment,
                 '\0', Char(42), Char(18))
      @test length(s) == 128

      t = parse_tags(s)
      @test t != nothing
      @test t.comment == comment
      @test t.track_number == 42
      @test t.genre_index == 18
    end

    @testset "partial comment" begin
      comment = "yo i'm a comment"
      s = string("TAG", repeat("X", 30+30+30), "1984", comment,
                 repeat('\0', 28-length(comment)),
                 '\0', Char(42), Char(18))
      @test length(s) == 128

      t = parse_tags(s)
      @test t != nothing
      @test t.comment == comment
      @test t.track_number == 42
      @test t.genre_index == 18
    end
  end
end

@testset "load_genres" begin
  genres = load_genres()
  @test genres != nothing
  @test length(genres) > 100
end

@testset "genre" begin
  function tag_with_genre(n)
    Tags("", "", "", "", "", n, nothing)
  end
  @test genre(tag_with_genre(1)) == "Classic Rock"
  @test genre(tag_with_genre(0)) == "Blues"
  @test genre(tag_with_genre(200)) == nothing
end
