class DB
  DEFAULT = {
    host: "mysql.orb.local",
    database: "lab31",
    username: "root",
    password: "pass"
  }.freeze
  
  def initialize(conf)
    @client = Mysql2::Client.new(**conf)
  end
  
  attr_reader :client
  
  def index
    client.prepare("SELECT * FROM individuals")
  end
  
  def create
    client.prepare <<-SQL
      INSERT INTO individuals (name, surname, passport, tin, snils, driverlicence)
      VALUES (?,?,?,?,?,?)
    SQL
  end
end