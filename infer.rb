Rails.application.eager_load! ## load Rails app
DB = RailsSequel.connect

#RDL::Config.instance.log_levels[:inference] = :debug
#RDL::Config.instance.log_levels[:typecheck] = :debug
#RDL::Config.instance.log_levels[:heuristic] = :trace

RDL::Config.instance.number_mode = true

require 'types/sequel'
require 'types/active_record'

require_relative 'orig_types.rb'

RDL.load_sequel_schema(DB)
RDL.load_rails_schema

RDL::Config.instance.promote_widen = true

## File below includes all the DB/Rails method annotations used during type checking. This time, they don't include type-level computations
#require './db_types.rb'

RDL.infer ResponsesCsvExporter, :answers_table, time: :later # got a MORE precise Table type, with 1 fewer type cast, after fixing an issue within comp type
RDL.infer ResponsesCsvExporter, :each_row, time: :later # I believe there's a potential nil error here with the value `current_row`. We call << on it even when it could be nil.
RDL.infer GraphsController, :aggregate_questions, time: :later # had to add type casts here, just like last time. Reason is we type check method until fixpoint is reached w.r.t. type environments. This raises issue when Hash<%bot, %bot> is not <= Hash<Integer, ...> due to Hash invariance. Not sure there's a way around this problem.
RDL.infer GraphsController, :line, time: :later # relies on previous method's type
RDL.infer GraphsController, :pie, time: :later
RDL.infer RootController, :get_new_questionnaires, time: :later
RDL.infer RootController, :dashboard, time: :later # I think this would work without casts with a fix to to_proc in type checker, AND use of comp types
RDL.infer Answer, 'self.find_answer', time: :later # really long union types for arguments. only `id` is called on args, so only way I can see to infer this is using names/NLP/fuzzy_match.

RDL.infer QuestionnairePermission, :email=, time: :later  ## had to add type cast due to lack of support for string keys in hash

# CONSTANT ERROR: RDL.infer Response, :verify_answers_for_page, time: :later ## Correctly finds Error!
RDL.infer Response, :answer_for_question, time: :later # imprecise arg type for this one. Could be fixed with either: practical inference rule for == comparison, or some kind of NLP or even Rails camelize (cause the answer is in the arg name)
RDL.infer QuestionnairesController, :index, time: :later 
RDL.infer QuestionnairesController, :show, time: :later 
RDL.infer AnswerController, :get_questionnaire, time: :later 
RDL.infer AnswerController, :save_answers, time: :later # needs cast essentially due to occurence typing
RDL.infer AnswerController, :preview, time: :later 
RDL.infer AnswerController, :questionnaire_closed, time: :later 
RDL.infer AnswerController, :prompt, time: :later # needs type cast because `error: incompatible types: `Array<%bot>' can't be assigned to variable of type `Array<Response>'`
# maybe this can be fixed if we promote [] to something other than Array<%bot>, like Array<x>
# RDL.infer AnswerController, :index, time: :later  # correctly finds error!
RDL.infer AnswerController, :resume, time: :later 
RDL.infer ResponsesController, :get_email_notification, time: :later





### variable and non-checked method types

## DB methods -- kind of a special case
RDL.type ResponsesCsvExporter, :db, "() -> SequelDB", wrap: false
RDL.type RailsSequel, 'self.connect', "() -> SequelDB", wrap: false

# below are automatically generated
RDL.type ResponsesCsvExporter, :questionnaire, "() -> Questionnaire", wrap: false
RDL.type ResponsesCsvExporter, :rotate, "() -> %bool", wrap: false

## METHOD TYPES

#RDL.type RootController, :index, "() -> %any", wrap: false
RDL.infer RootController, :index, time: :later # got it! as () -> String

## previous relies on these:
#RDL.infer Journey::SiteOptions, 'self.site_root', time: :later # got (%bot) -> %bot. output could be inferred with fixed point approach. input might be inferred with Bree's rule re: "if there are no upper bounds use lower bounds."


#RDL.type ApplicationController, :current_ability, "() -> Ability", wrap: false
RDL.infer ApplicationController, :current_ability, time: :later

#RDL.infer Questionnaire, :tag_names, time: :later

#RDL.type AnswerController, :answer_given, "(Integer) -> %bool", wrap: false
RDL.infer AnswerController, :answer_given, time: :later


#RDL.type AnswerController, :validate_answers, "(Response, Page) -> Array<String>", wrap: false
RDL.infer AnswerController, :validate_answers, time: :later

#RDL.type Person, :name, "() -> String", wrap: false
#RDL.infer Person, :name, time: :later

#RDL.type Question, :purpose, '() -> String', wrap: false
#RDL.infer Question, :purpose, time: :later



## VARIABLE TYPES
#RDL.var_type GraphsController, :@questionnaire, "Questionnaire"
RDL.infer_var_type GraphsController, :@questionnaire ## got it! with no effects elsewhere
#RDL.var_type GraphsController, :@questions, "ActiveRecord_Relation<Question>"
RDL.infer_var_type GraphsController, :@questions ## got it! with no effects elsewhere
#RDL.var_type GraphsController, :@question, "Question"
RDL.infer_var_type GraphsController, :@question  

#RDL.var_type GraphsController, :@counts, "Hash<Integer, Hash<String, Integer>>"
RDL.infer_var_type GraphsController, :@counts

#RDL.var_type GraphsController, :@min, "Integer"
RDL.infer_var_type GraphsController, :@min ## could only infer %bot, but didn't affect other inferred types. might help to use "fixed point" approach, or to use name.

#RDL.var_type GraphsController, :@max, "Integer"
RDL.infer_var_type GraphsController, :@max ## same as @min

#RDL.var_type GraphsController, :@geom, "String"
RDL.infer_var_type GraphsController, :@geom 

#RDL.var_type GraphsController, :@graph, "Gruff::Base"
RDL.infer_var_type GraphsController, :@graph ## inferred Gruff::Line... I think this may be more precise

#RDL.var_type GraphsController, :@labels, "Hash<Integer, String>"
RDL.infer_var_type GraphsController, :@labels ## key type is inferred as { { { GraphsController# var: @min }#upto block_arg: (arg :answer) }#to_s ret: ret } ... potentially fixed with fixed point approach.

#RDL.var_type GraphsController, :@series, "Hash<Question, Array<Integer>>"
RDL.infer_var_type GraphsController, :@series ## inferred as Hash<{ { GraphsController# var: @questions }#each block_arg: (arg :question) }, (Array<t> or { { GraphsController# var: @series }#[] ret: ret })> ... again I think would be fixed with fixed point approach

#RDL.var_type GraphsController, :@answercounts, "Hash<String, Integer>"
RDL.infer_var_type GraphsController, :@answercounts ## infers %bot. once again, could be fixed with fix point approach

#RDL.var_type RootController, :@new_questionnaires, "ActiveRecord_Relation<Questionnaire>"
RDL.infer_var_type RootController, :@new_questionnaires

#RDL.var_type RootController, :@page_title, "String"
RDL.infer_var_type RootController, :@page_title # inferred precise string type 'Dashboard'

#RDL.var_type RootController, :@my_questionnaires, "Array<Questionnaire>"
RDL.infer_var_type RootController, :@my_questionnaires

#RDL.var_type RootController, :@responses, "ActiveRecord_Relation<JoinTable<Response, Questionnaire>>"
RDL.infer_var_type RootController, :@responses

#RDL.var_type QuestionnairesController, :@questionnaires, "ActiveRecord_Relation<JoinTable<Questionnaire, Person or QuestionnairePermission or Tag>>"
RDL.infer_var_type QuestionnairesController, :@questionnaires

#RDL.var_type QuestionnairesController, :@rss_url, "String"
RDL.infer_var_type QuestionnairesController, :@rss_url

#RDL.var_type QuestionnairesController, :@questionnaire, "Questionnaire"
RDL.infer_var_type QuestionnairesController, :@questionnaire


#RDL.var_type AnswerController, :@questionnaire, "Questionnaire"
RDL.infer_var_type AnswerController, :@questionnaire

#RDL.var_type AnswerController, :@resp, "Response"
RDL.infer_var_type AnswerController, :@resp

#RDL.var_type AnswerController, :@page, "Page"
RDL.infer_var_type AnswerController, :@page ## inferred as %bot


#RDL.var_type AnswerController, :@previewing, "%bool"
RDL.infer_var_type AnswerController, :@previewing

#RDL.var_type AnswerController, :@error_messages, "Array<String>"
RDL.infer_var_type AnswerController, :@error_messages

RDL.var_type AnswerController, :@all_responses, "Array<Response>"
#RDL.infer_var_type AnswerController, :@all_responses ## inferred as [], because var types are dropped from 

RDL.var_type AnswerController, :@responses, "Array<Response>"
#RDL.infer_var_type AnswerController, :@responses ## Array subtyping issue

#RDL.var_type :$!, "String"
RDL.infer_var_type :$!


#RDL.var_type ResponsesController, :@questionnaire, "Questionnaire"
RDL.infer_var_type ResponsesController, :@questionnaire


#RDL.var_type ResponsesController, :@email_notification, "EmailNotification"
RDL.infer_var_type ResponsesController, :@email_notification


=begin
RDL.type QuestionnairePermission, 'self.for_person', "(Person) -> ActiveRecord_Relation<QuestionnairePermission>", wrap: false ## comes from rails scope
RDL.type Object, :blank?, "() -> %bool", wrap: false
RDL.type CanCan::ControllerAdditions, :authorize!, "(Symbol, %any) -> %bool", wrap: false
RDL.type Gruff::Line, :initialize, '(String) -> self', wrap: false
RDL.type Gruff::Pie, :initialize, '(String) -> self', wrap: false
RDL.type Gruff::Base, :labels=, '(Hash<Integer, String>) -> Hash<Integer, String>', wrap: false
RDL.type Gruff::Base, :data, '(String, Array<Integer>) -> Hash<Integer, String>', wrap: false
RDL.type Gruff::Base, :title=, '(String) -> String', wrap: false
RDL.type GraphsController, :set_journey_theme, "(Gruff::Base) -> %any", wrap: false
RDL.type Gruff::Base, :to_blob, "() -> self", wrap: false
RDL.type ActionView::Helpers::TextHelper, :truncate, "(String) -> String", wrap: false
RDL.type CanCan::ModelAdditions::ClassMethods, :accessible_by, "(Ability) -> self", wrap: false
RDL.type Devise::Controllers::Helpers, :person_signed_in?, "() -> %bool", wrap: false
RDL.type Devise::Controllers::Helpers, :current_person, "() -> Person", wrap: false
RDL.type ActiveRecord_Relation, 'allows_anything', "() -> self", wrap: false
RDL.type ActiveRecord_Relation, :no_answer_for, "(Question) -> self", wrap: false
RDL.type ActiveSupport::Logger, :info, "(String) -> %any", wrap: false
RDL.type IllyanClient::Person, :initialize,  "(%any) -> self", wrap: false
RDL.type IllyanClient::Person, :attributes,  "() -> Hash<String, String>", wrap: false
RDL.type ActiveModel::Errors, :add, "(Symbol or String, Symbol or String) -> %any", wrap: false
RDL.type Ability, :initialize, "(%any) -> self"
RDL.type ActiveRecord_Relation, :paginate, "({ page: Integer, per_page: Integer }) -> self", wrap: false
RDL.type QuestionnairesController, :questionnaires_url, "(?{ format: String }) -> String", wrap: false  ## automatically defined
RDL.type ActionController::MimeResponds::Collector, :html, "() { () -> %any } -> %any", wrap: false
RDL.type ActionController::MimeResponds::Collector, :rss, "() { () -> %any } -> %any", wrap: false
RDL.type ActionController::MimeResponds::Collector, :xml, "() { () -> %any } -> %any", wrap: false
RDL.type ActionController::MimeResponds::Collector, :json, "() { () -> %any } -> %any", wrap: false
RDL.type ActiveRecord::Base, :can?, "(Symbol, ActiveRecord::Base) -> %bool", wrap: false
RDL.type ActionController::RackDelegation, :headers, "() -> Hash<String, String>", wrap: false
RDL.type :'ActionController::Instrumentation', :render, '(?String or Symbol, {content_type: ?String, layout: ?%bool or String, action: ?String or Symbol, location: ?String, nothing: ?%bool, text: ?String, status: ?Symbol, content_type: ?String, formats: ?Symbol or Array<Symbol>, locals: ?Hash<Symbol, %any>, xml: ?Builder::XmlMarkup, json: ?String, id: ?Integer, page: ?Integer }) -> Array<String>'
RDL.type :'ActionController::Instrumentation', :redirect_to, '({id: ?Integer, controller: ?String, action: ?String, notice: ?String, alert: ?String, current_page: ?Integer, page: ?Integer }, ?{ status: Integer }) -> String'
RDL.type ActiveRecord_Relation, :notify_on_response_submit, "() -> self", wrap: false
RDL.type Object, :try, "(Symbol) -> Object", wrap: false
RDL.type Object, :present?, "() -> %bool", wrap: false
RDL.type ActionMailer::MessageDelivery, :deliver_later, "() -> %any", wrap: false
RDL.type ActionController::Base, :flash, "() -> Hash<Symbol, String or Array<String>>", wrap: false
RDL.type ActiveRecord::Base, 'respond_to?', "(Symbol or String) -> %bool", wrap: false
RDL.type Builder::XmlMarkup, :initialize, "(%any) -> self", wrap: false
RDL.type NotificationMailer, 'self.response_submitted', "(Response, Person) -> ActionMailer::MessageDelivery", wrap: false
=end

RDL.type AnswerController, :params, "() -> { id: Integer, question: Hash<String, String>, current_page: Integer, commit: String, page: Integer }", wrap: false
RDL.type GraphsController, :params, "() -> { question_ids: Array<Integer>, question_id: Integer, geom: String, skip_no_answer: %bool }", wrap: false
RDL.type QuestionnairesController, :params, "() -> { title: String, tag: String, page: Integer, id: Integer, attributes: Array<String>, questionnaire: Questionnaire, file: String }", wrap: false
RDL.type ActionController::Metal, :session, "() -> Hash<String, Integer>", wrap: false


RDL.type IllyanClient::Person, :save,  "() -> %any", wrap: false
#RDL.infer IllyanClient::Person, :save, time: :later

RDL.type :'ActionController::Instrumentation', :render, '(?String or Symbol, {content_type: ?String, layout: ?%bool or String, action: ?String or Symbol, location: ?String, nothing: ?%bool, text: ?String, status: ?Symbol, content_type: ?String, formats: ?Symbol or Array<Symbol>, locals: ?Hash<Symbol, %any>, xml: ?Builder::XmlMarkup, json: ?String, id: ?Integer, page: ?Integer }) -> Array<String>'

RDL.type :'ActionController::Instrumentation', :redirect_to, '({id: ?Integer, controller: ?String, action: ?String, notice: ?String, alert: ?String, current_page: ?Integer, page: ?Integer }, ?{ status: Integer }) -> String'

RDL.type NotificationMailer, 'self.response_submitted', "(Response, Person) -> ActionMailer::MessageDelivery", wrap: false

=begin
RDL.infer_var_type ResponsesController, :@email_notification
RDL.infer_var_type ResponsesController, :@questionnaire
RDL.infer ResponsesController, :get_email_notification, time: :later
=end

RDL.do_infer :later, num_times: 11
