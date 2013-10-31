object false

node(:pagination) do
  pagination_hash(@songs)
end

child @songs, object_root: false do
  extends "songs/base"
end
