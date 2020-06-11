### Annotations for type checked methods.
## Methods located in ~/journey/app/exporters/responses_csv_exporter.rb
RDL.orig_type ResponsesCsvExporter, :answers_table, "() -> Table<{ id: Integer, response_id: Integer, question_id: Integer, value: String, created_at: Time or DateTime, updated_at: Time or DateTime, questionnaire_id: Integer, saved_page: Integer, submitted: false or true, person_id: Integer, submitted_at: Time or DateTime, notes: String, type: String, position: Integer, caption: String, required: false or true, min: Integer, max: Integer, step: Integer, page_id: Integer, default_answer: String, layout: String, radio_layout: String, title: String, option: String, output_value: String, __all_joined: :questions or :pages or :responses or :answers or :question_options, __last_joined: :question_options, __selected: nil, __orm: false }>", wrap: false, typecheck: :later
RDL.orig_type ResponsesCsvExporter, :each_row, "() {(%any) -> %any } -> %any", wrap: false, typecheck: :later
## Methods located in ~/journey/app/controllers/graphs_controller.rb
RDL.orig_type GraphsController, :aggregate_questions, "(Array<Integer> or Integer) -> Hash<Integer, Hash<String, Integer>>", wrap: false, typecheck: :later
RDL.orig_type GraphsController, :line, "() -> Array<String>", wrap: false, typecheck: :later
RDL.orig_type GraphsController, :pie, "() -> Array<String>", wrap: false, typecheck: :later
## Methods located in ~/journey/app/controllers/root_controller.rb
RDL.orig_type RootController, :get_new_questionnaires, "() -> ActiveRecord_Relation<Questionnaire>", wrap: false, typecheck: :later
RDL.orig_type RootController, :dashboard, "() -> %any", wrap: false, typecheck: :later
## Methods located in ~/journey/app/models/answer.rb
RDL.orig_type Answer, 'self.find_answer', "(Response, Question) -> Answer", wrap: false, typecheck: :later
## Methods located in ~/journey/app/models/questionnaire_permission.rb
RDL.orig_type QuestionnairePermission, :email=, "(String) -> %any", wrap: false, typecheck: :later
## Methods located in ~/journey/app/models/response.rb
## Bug found in the method below.
RDL.orig_type Response, :verify_answers_for_page, "(Page) -> %any", wrap: false, typecheck: :later
RDL.orig_type Response, :answer_for_question, "(Question) -> Answer", wrap: false, typecheck: :later
## Methods located in ~/journey/app/controllers/questionnaires_controller.rb
RDL.orig_type QuestionnairesController, :index, "() -> Array<String> or String", wrap: false, typecheck: :later
RDL.orig_type QuestionnairesController, :show, "() -> Array<String> or String", wrap: false, typecheck: :later
## Methods located in ~/journey/app/controllers/answer_controller.rb
RDL.orig_type AnswerController, :get_questionnaire, "() -> Questionnaire", wrap: false, typecheck: :later
RDL.orig_type AnswerController, :save_answers, "() -> String", wrap: false, typecheck: :later
RDL.orig_type AnswerController, :preview, "() -> Array<String>", wrap: false, typecheck: :later
RDL.orig_type AnswerController, :questionnaire_closed, "() -> Questionnaire", wrap: false, typecheck: :later
RDL.orig_type AnswerController, :prompt, "() -> Array<Response>", wrap: false, typecheck: :later
## Bug found in the method below
RDL.orig_type AnswerController, :index, "() -> %any", wrap: false, typecheck: :later
RDL.orig_type AnswerController, :resume, "() -> String", wrap: false, typecheck: :later
## Methods located in ~/journey/app/controllers/responses_controller.rb
RDL.orig_type ResponsesController, :get_email_notification, "() -> EmailNotification", wrap: false, typecheck: :later



### Annotations for variables and non-checked methods. These methods either come from the Journey app or from external libraries.
RDL.orig_type ResponsesCsvExporter, :db, "() -> SequelDB", wrap: false
RDL.orig_type RailsSequel, 'self.connect', "() -> SequelDB", wrap: false
RDL.orig_type ResponsesCsvExporter, :questionnaire, "() -> Questionnaire", wrap: false
RDL.orig_type ResponsesCsvExporter, :rotate, "() -> %bool", wrap: false
RDL.orig_type Object, :blank?, "() -> %bool", wrap: false
RDL.orig_var_type GraphsController, :@questionnaire, "Questionnaire"
RDL.orig_var_type GraphsController, :@questions, "ActiveRecord_Relation<Question>"
RDL.orig_var_type GraphsController, :@question, "Question"
RDL.orig_var_type GraphsController, :@counts, "Hash<Integer, Hash<String, Integer>>"
RDL.orig_var_type GraphsController, :@min, "Integer"
RDL.orig_var_type GraphsController, :@max, "Integer"
RDL.orig_var_type GraphsController, :@geom, "String"
RDL.orig_var_type GraphsController, :@graph, "Gruff::Base"
RDL.orig_var_type GraphsController, :@labels, "Hash<Integer, String>"
RDL.orig_var_type GraphsController, :@series, "Hash<Question, Array<Integer>>"
RDL.orig_var_type GraphsController, :@answercounts, "Hash<String, Integer>"
RDL.orig_type ActiveRecord_Relation, :valid, "() -> ``if trec.params[0].name == 'Response' then trec else raise 'unexpected param type' end ``", wrap: false
RDL.orig_type ActiveRecord_Relation, :no_answer_for, "(``if trec.params[0].name == 'Response' then RDL::Type::NominalType.new(Question) else raise 'unexpected param type' end``) -> self", wrap: false
RDL.orig_type CanCan::ControllerAdditions, :authorize!, "(Symbol, %any) -> %bool", wrap: false
RDL.orig_type GraphsController, :params, "() -> { question_ids: Array<Integer>, question_id: Integer }", wrap: false
RDL.orig_type Question, :min, '() -> Integer', wrap: false
RDL.orig_type Question, :max, '() -> Integer', wrap: false
RDL.orig_type Gruff::Line, :initialize, '(String) -> self', wrap: false
RDL.orig_type Gruff::Pie, :initialize, '(String) -> self', wrap: false
RDL.orig_type Gruff::Base, :labels=, '(Hash<Integer, String>) -> Hash<Integer, String>', wrap: false
RDL.orig_type Gruff::Base, :data, '(String, Array<Integer>) -> Hash<Integer, String>', wrap: false
RDL.orig_type Gruff::Base, :title=, '(String) -> String', wrap: false
RDL.orig_type GraphsController, :set_journey_theme, "(Gruff::Base) -> %any", wrap: false
RDL.orig_type Gruff::Base, :to_blob, "() -> self", wrap: false
RDL.orig_type ActionView::Helpers::TextHelper, :truncate, "(String) -> String", wrap: false
RDL.orig_var_type RootController, :@new_questionnaires, "ActiveRecord_Relation<Questionnaire>"
RDL.orig_var_type RootController, :@page_title, "String"
RDL.orig_var_type RootController, :@my_questionnaires, "Array<Questionnaire>"
RDL.orig_var_type RootController, :@responses, "ActiveRecord_Relation<JoinTable<Response, Questionnaire>>"
RDL.orig_type Devise::Controllers::Helpers, :person_signed_in?, "() -> %bool", wrap: false
RDL.orig_type Devise::Controllers::Helpers, :current_person, "() -> Person", wrap: false
RDL.orig_type RootController, :index, "() -> %any", wrap: false
RDL.orig_type QuestionnairePermission, 'self.for_person', "(Person) -> ActiveRecord_Relation<QuestionnairePermission>", wrap: false
RDL.orig_type ActiveRecord_Relation, 'allows_anything', "() -> ``if trec.params[0].name == 'QuestionnairePermission' then trec else raise 'unexpected type' end``", wrap: false
RDL.orig_type ActiveSupport::Logger, :info, "(String) -> %any", wrap: false
RDL.orig_type IllyanClient::Person, :initialize,  "(%any) -> self", wrap: false
RDL.orig_type IllyanClient::Person, :save,  "() -> %any", wrap: false
RDL.orig_type IllyanClient::Person, :attributes,  "() -> Hash<String, String>", wrap: false
RDL.orig_var_type :$!, "String"
RDL.orig_type ActiveModel::Errors, :add, "(Symbol or String, Symbol or String) -> %any", wrap: false
RDL.orig_type QuestionnairesController, :params, "() -> { title: String, tag: String, page: Integer, id: String, attributes: Array<String> }", wrap: false
RDL.orig_type ApplicationController, :current_ability, "() -> Ability", wrap: false
RDL.orig_type ActiveRecord_Relation, :paginate, "({ page: Integer, per_page: Integer }) -> self", wrap: false
RDL.orig_var_type QuestionnairesController, :@questionnaires, "ActiveRecord_Relation<JoinTable<Questionnaire, QuestionnairePermission or Person or Tag>>"
RDL.orig_var_type QuestionnairesController, :@questionnaire, "Questionnaire"
RDL.orig_var_type QuestionnairesController, :@rss_url, "String"
RDL.orig_type QuestionnairesController, :questionnaires_url, "(?{ format: String }) -> String", wrap: false
RDL.orig_type ActionController::MimeResponds::Collector, :html, "() { () -> %any } -> %any", wrap: false
RDL.orig_type ActionController::MimeResponds::Collector, :rss, "() { () -> %any } -> %any", wrap: false
RDL.orig_type ActionController::MimeResponds::Collector, :xml, "() { () -> %any } -> %any", wrap: false
RDL.orig_type ActionController::MimeResponds::Collector, :json, "() { () -> %any } -> %any", wrap: false
RDL.orig_type ActiveRecord::Base, :can?, "(Symbol, ActiveRecord::Base) -> %bool", wrap: false
RDL.orig_type ActionController::RackDelegation, :headers, "() -> Hash<String, String>", wrap: false
RDL.orig_type Questionnaire, :to_xml, "() -> Builder::XmlMarkup", wrap: false
RDL.orig_type :'ActionController::Instrumentation', :render, '(?String or Symbol, {content_type: ?String, layout: ?%bool or String, action: ?String or Symbol, location: ?String, nothing: ?%bool, text: ?[to_s: () -> String], status: ?Symbol, content_type: ?String, formats: ?Symbol or Array<Symbol>, locals: ?Hash<Symbol, %any>, xml: ?Builder::XmlMarkup, json: ?String, id: ?Integer, page: ?Integer }) -> Array<String>'
RDL.orig_type AnswerController, :params, "() -> { id: String, question: Hash<String, String>, current_page: Integer, commit: String, page: Integer }", wrap: false
RDL.orig_var_type AnswerController, :@questionnaire, "Questionnaire"
RDL.orig_var_type AnswerController, :@resp, "Response"
RDL.orig_var_type AnswerController, :@page, "Page"
RDL.orig_var_type AnswerController, :@previewing, "%bool"
RDL.orig_var_type AnswerController, :@error_messages, "Array<String>"
RDL.orig_var_type AnswerController, :@all_responses, "Array<Response>"
RDL.orig_var_type AnswerController, :@responses, "Array<Response>"
RDL.orig_type ActionController::Metal, :session, "() -> Hash<String, Integer>", wrap: false
RDL.orig_type AnswerController, :answer_given, "(Integer) -> %bool", wrap: false
RDL.orig_type :'ActionController::Instrumentation', :redirect_to, '({id: ?Integer, controller: ?String, action: ?String, notice: ?String, alert: ?String, current_page: ?Integer, page: ?Integer }) -> String'
RDL.orig_type AnswerController, :validate_answers, "(Response, Page) -> Array<String>", wrap: false
RDL.orig_type ActiveRecord_Relation, :notify_on_response_submit, "() -> ``if trec.params[0].name == 'EmailNotification' then trec else raise 'unexpected type' end``", wrap: false
RDL.orig_type NotificationMailer, 'self.response_submitted', "(Response, Person) -> ActionMailer::MessageDelivery", wrap: false
RDL.orig_type ActionMailer::MessageDelivery, :deliver_later, "() -> %any", wrap: false
RDL.orig_type ActionController::Base, :flash, "() -> Hash<Symbol, String or Array<String>>", wrap: false
RDL.orig_var_type ResponsesController, :@questionnaire, "Questionnaire"
RDL.orig_var_type ResponsesController, :@email_notification, "EmailNotification"
RDL.orig_type CanCan::ModelAdditions::ClassMethods, :accessible_by, "(Ability) -> self", wrap: false

