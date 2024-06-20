class App < Roda
  using Refinements
  
  plugin :render
  plugin :sessions, secret: "secret" * 12
  
  db = DB.new(DB::DEFAULT)
    
  route do |r|
    r.root do
      @individuals = db.index.execute
      @errors = r.session.delete("errors") || []
      
      view "index"
    end
    
    r.post "add" do
      db.create.execute(
        r.params["name"].presence,
        r.params["surname"].presence,
        r.params["passport"].presence,
        r.params["tin"].presence,
        r.params["snils"].presence,
        r.params["driverlicence"].presence,
        r.params["note"].presence,
      )
    rescue Mysql2::Error => e
      r.session["errors"] = [e.message]
    ensure
      r.redirect "/"
    end
  end
end