require 'sqlite3'
require 'singleton'

class QuestionsDB < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class User
  attr_accessor :fname, :lname
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.find_by_id(id)
    data = QuestionsDB.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
    User.new(data.first)
  end

  def self.find_by_name(fname, lname)
    data = QuestionsDB.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL
    User.new(data.first)
  end

  def authored_questions
    Question.find_by_author(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    data = QuestionsDB.instance.execute(<<-SQL, @id)
      SELECT
        CAST(COUNT(question_likes.id) AS FLOAT) / COUNT(DISTINCT(questions.id)) AS q
      FROM
        questions
      LEFT OUTER JOIN question_likes ON question_likes.question_id = questions.id
      WHERE
        questions.user_id = ?
    SQL
    data.first['q']
  end

  def save
    @id ? update : create
  end

  def update
    QuestionsDB.instance.execute(<<-SQL, @fname, @lname, @id)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
        id = ?
    SQL
  end

  def create
    QuestionsDB.instance.execute(<<-SQL, @fname, @lname)
      INSERT INTO
        users (fname, lname)
      VALUES
        (?, ?)
    SQL
    @id = QuestionsDB.instance.last_insert_row_id
  end
end

class Question
  attr_accessor :title, :body
  attr_reader :id, :user_id

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def self.find_by_id(id)
    data = QuestionsDB.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL
    Question.new(data.first)
  end

  def self.find_by_author(author_id)
    data = QuestionsDB.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = ?
    SQL
    data.map { |datum| Question.new(datum) }
  end

  def author
    data = QuestionsDB.instance.execute(<<-SQL, @user_id)
      SELECT
        *
      FROM
        questions
      JOIN users ON questions.user_id = users.id
      WHERE
        user_id = ?
    SQL
    User.new(data.first)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def most_liked(n)
    QuestionLike.most_liked_question(n)
  end

  def save
    @id ? update : create
  end

  def update
    QuestionsDB.instance.execute(<<-SQL, @title, @body, @user_id, @id)
      UPDATE
        questions
      SET
        title = ?, body = ?, user_id = ?
      WHERE
        id = ?
    SQL
  end

  def create
    QuestionsDB.instance.execute(<<-SQL, @title, @body, @user_id)
      INSERT INTO
        questions (title, body, user_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = QuestionsDB.instance.last_insert_row_id
  end
end

class Reply
  attr_accessor :body
  attr_reader :question_id, :id, :user_id, :parent_id

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @body = options['body']
    @user_id = options['user_id']
    @parent_id = options['parent_id']
  end

  def self.find_by_id(id)
    data = QuestionsDB.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    Reply.new(data.first)
  end

  def self.find_by_user_id(user_id)
    data = QuestionsDB.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_question_id(question_id)
    data = QuestionsDB.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL
    data.map { |datum| Reply.new(datum) }
  end

  def author
    data = QuestionsDB.instance.execute(<<-SQL, @user_id)
      SELECT
        *
      FROM
        replies
      JOIN users ON replies.user_id = users.id
      WHERE
        user_id = ?
    SQL
    User.new(data.first)
  end

  def question
    data = QuestionsDB.instance.execute(<<-SQL, @question_id)
      SELECT
        *
      FROM
        replies
      JOIN questions ON replies.question_id = questions.id
      WHERE
        question_id = ?
    SQL
    Question.new(data.first)
  end

  def parent_reply
    data = QuestionsDB.instance.execute(<<-SQL, @parent_id)
      SELECT
        *
      FROM
        replies r1
      JOIN replies r2 ON r1.parent_id = r2.id
      WHERE
        r1.parent_id = ?
    SQL
    Reply.new(data.first)
  end

  def child_replies
    data = QuestionsDB.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies r1
      JOIN replies r2 ON r1.id = r2.parent_id
      WHERE
        r1.id = ?
    SQL
    data.map { |datum| Reply.new(datum) }
  end

  def save
    @id ? update : create
  end

  def update
    QuestionsDB.instance.execute(<<-SQL, @question_id, @body, @user_id, @parent_id, @id)
      UPDATE
        replies
      SET
        question_id = ?, body = ?, user_id = ?, parent_id = ?
      WHERE
        id = ?
    SQL
  end

  def create
    QuestionsDB.instance.execute(<<-SQL, @question_id, @body, @user_id, @parent_id)
      INSERT INTO
        replies (question_id, body, user_id, parent_id)
      VALUES
        (?, ?, ?, ?)
    SQL
    @id = QuestionsDB.instance.last_insert_row_id
  end
end

class QuestionFollow
  attr_accessor :user_id, :question_id
  attr_reader :id

  def initialize(options)
    @user_id = options['user_id']
    @question_id = options['question_id']
    @id = options['id']
  end

  def self.find_by_id(id)
    data = QuestionsDB.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        id = ?
    SQL
    QuestionFollow.new(data.first)
  end

  def self.followers_for_question_id(question_id)
    data = QuestionsDB.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_follows
      JOIN users ON question_follows.user_id = users.id
      WHERE
        question_id = ?
    SQL

    data.map{ |datum| User.new(datum)}
  end

  def self.followed_questions_for_user_id(user_id)
    data = QuestionsDB.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        question_follows
      JOIN questions ON question_follows.question_id = questions.id
      WHERE
        question_follows.user_id = ?
    SQL

    data.map{ |datum| Question.new(datum)}
  end

  def self.most_followed_questions(n)
    data = QuestionsDB.instance.execute(<<-SQL, n)
      SELECT
        *
      FROM
        question_follows
      JOIN questions ON question_follows.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(*) DESC
      LIMIT ?
    SQL

    data.map { |datum| Question.new(datum) }
  end
end

class QuestionLike
  attr_accessor :user_id, :question_id
  attr_reader :id

  def initialize(options)
    @user_id = options['user_id']
    @question_id = options['question_id']
    @id = options['id']
  end

  def self.find_by_id(id)
    data = QuestionsDB.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL
    QuestionLike.new(data.first)
  end

  def self.likers_for_question_id(question_id)
    data = QuestionsDB.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_likes
      JOIN users ON question_likes.user_id = users.id
      WHERE
        question_id = ?
    SQL

    data.map { |datum| User.new(datum) }
  end

  def self.num_likes_for_question_id(question_id)
    data = QuestionsDB.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*)
      FROM
        question_likes
      JOIN users ON question_likes.user_id = users.id
      WHERE
        question_likes.question_id = ?
    SQL
    data.first['COUNT(*)']
  end

  def self.liked_questions_for_user_id(user_id)
    data = QuestionsDB.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        question_likes
      JOIN questions ON question_likes.question_id = questions.id
      WHERE
        question_likes.user_id = ?
    SQL

    data.map { |datum| Question.new(datum) }
  end

  def self.most_liked_question(n)
    data = QuestionsDB.instance.execute(<<-SQL, n)
      SELECT
        *
      FROM
        question_likes
      JOIN questions ON question_likes.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(*) DESC
      LIMIT ?
    SQL

    data.map { |datum| Question.new(datum) }
  end

end
