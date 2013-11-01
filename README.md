# NeonRoots's Juckebox Api

This is a simple API for NeonRoots

**Subscribe your bar to the app:**

    $ curl http://localhost:3000/bars \
    -d "name=My Bar Name"

**Add Song:**

    $ curl http://localhost:3000/songs -H 'Authorization: Token token="ADMIN_TOKEN"' \
    -d "title=Every Breath You Take" \
    -d "artist=The Police" \
    -d "album=Synchronicity" \
    -d "price=80"

**List songs from server:**

    $ curl http://localhost:3000/songs \
    -H 'Authorization: Token token="admin_token or bar_owner_token"'

**List songs on sale:**

    $ curl http://localhost:3000/songs/on_sale \
    -H 'Authorization: Token token="admin_token or bar_owner_token"'

**Buy Song:**

    $ curl http://localhost:3000/bars/:bar_id/songs \
    -H 'Authorization: Token token="bar_owner_token"' \
    -d "song_id=1"

**Run spec and make them pass:**

    $ ADMIN_TOKEN=berna bundle exec rspec spec/
