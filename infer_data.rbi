# typed: strong
class ResponsesCsvExporter
  # RDL Type: () -> Table<{ id: Number, response_id: Number, question_id: Number, value: String, created_at: (DateTime or Time), updated_at: (DateTime or Time), questionnaire_id: Number, saved_page: Number, submitted: (false or true), person_id: Number, submitted_at: (DateTime or Time), notes: String, type: String, position: Number, caption: String, required: (false or true), min: Number, max: Number, step: Number, page_id: Number, default_answer: String, layout: String, radio_layout: String, title: String, option: String, output_value: String, __all_joined: (:answers or :pages or :question_options or :questions or :responses), __last_joined: :question_options, __selected: nil, __orm: false }>
  sig { returns(Table[T::Hash[Symbol, T.any(DateTime, FalseClass, NilClass, Integer, String, Symbol, Time, TrueClass)]]) }
  def answers_table; end

  # RDL Type: () {((Array<(DateTime or String or Time)>) -> XXX and (Array<(Number or String)>) -> XXX and (Array<String>) -> XXX)} -> nil
  sig { void }
  def each_row; end
end

class GraphsController
  # RDL Type: ((Array<Number> or Number)) -> Hash<Number, Hash<String, Number>>
  sig { params(question_ids: T.any(T::Array[Integer], Integer)).returns(T::Hash[Integer, T::Hash[String, Integer]]) }
  def aggregate_questions(question_ids); end

  # RDL Type: () -> Array<String>
  sig { returns(T::Array[String]) }
  def line; end

  # RDL Type: () -> Array<String>
  sig { returns(T::Array[String]) }
  def pie; end
end

class RootController
  # RDL Type: () -> ActiveRecord_Relation<Questionnaire>
  sig { returns(ActiveRecord_Relation[Questionnaire]) }
  def get_new_questionnaires; end

  # RDL Type: () -> (ActiveRecord_Relation<JoinTable<Response, Questionnaire>> or String)
  sig { returns(T.any(ActiveRecord_Relation[JoinTable[Response, Questionnaire]], String)) }
  def dashboard; end

  # RDL Type: () -> String
  sig { returns(String) }
  def index; end
end

class [s]Answer
  # RDL Type: (Response, Response) -> Answer
  sig { params(resp: Response, question: Response).returns(Answer) }
  def find_answer(resp, question); end
end

class QuestionnairePermission
  # RDL Type: ((String or Symbol)) -> (Array<String> or Person)
  sig { params(email: T.any(String, Symbol)).returns(T.any(T::Array[String], Person)) }
  def email=(email); end
end

class Response
  # RDL Type: (XXX) -> Answer
  sig { params(question: T.untyped).returns(Answer) }
  def answer_for_question(question); end
end

class QuestionnairesController
  # RDL Type: () -> (Array<String> or String)
  sig { returns(T.any(T::Array[String], String)) }
  def index; end

  # RDL Type: () -> (Array<String> or String)
  sig { returns(T.any(T::Array[String], String)) }
  def show; end
end

class AnswerController
  # RDL Type: () -> Questionnaire
  sig { returns(Questionnaire) }
  def get_questionnaire; end

  # RDL Type: () -> String
  sig { returns(String) }
  def save_answers; end

  # RDL Type: () -> Array<String>
  sig { returns(T::Array[String]) }
  def preview; end

  # RDL Type: () -> Questionnaire
  sig { returns(Questionnaire) }
  def questionnaire_closed; end

  # RDL Type: () -> Array<Response>
  sig { returns(T::Array[Response]) }
  def prompt; end

  # RDL Type: () -> String
  sig { returns(String) }
  def resume; end

  # RDL Type: ([ to_s: () -> String ]) -> (false or true)
  sig { params(question_id: T.untyped).returns(T.any(FalseClass, TrueClass)) }
  def answer_given(question_id); end

  # RDL Type: (Response, [ questions: () -> XXX ]) -> Array<String>
  sig { params(resp: Response, page: T.untyped).returns(T::Array[String]) }
  def validate_answers(resp, page); end
end

class ResponsesController
  # RDL Type: () -> EmailNotification
  sig { returns(EmailNotification) }
  def get_email_notification; end
end

class ApplicationController
  # RDL Type: () -> Ability
  sig { returns(Ability) }
  def current_ability; end
end
