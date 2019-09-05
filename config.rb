# rubocop:disable Style/AsciiComments Style/MutableConstant Style/NumericLiterals

# Токен для Slack бота
SLACK_BOT_TOKEN = ''

# Ваш логин и пароль от TeachBase
USER_LOGIN = ''
USER_PASSWORD = ''

# Каналы для уведомлений
RUBY_CHANNEL = '#think-ruby'
VUE_CHANNEL = '#thik-vuejs'

# Параметры для запроса
RUBY_PARAMS = {
  'labels[22588][]' => 22591, # Только третья группа (можно посмотреть в запросе на TeachBase)
  'filter[checked]' => false, # Только раздел "для проверки"
  per_page: 100
}.freeze

VUEJS_PARAMS = {
  'filter[checked]' => false,
  per_page: 100
}.freeze

COURSES = [
  { name: 'Поток: 11', course_session_id: 87912, params: RUBY_PARAMS, channel: RUBY_CHANNEL },
  { name: 'Поток: 12', course_session_id: 101114, params: RUBY_PARAMS, channel: RUBY_CHANNEL },
  { name: 'Поток: 13', course_session_id: 113671, params: RUBY_PARAMS, channel: RUBY_CHANNEL },
  { name: 'Поток: 14', course_session_id: 120569, params: RUBY_PARAMS, channel: RUBY_CHANNEL },
  { name: 'Поток: 15', course_session_id: 124711, params: RUBY_PARAMS, channel: RUBY_CHANNEL },
  { name: 'Поток: 16', course_session_id: 130717, params: RUBY_PARAMS, channel: RUBY_CHANNEL },
  { name: 'Поток: 17', course_session_id: 136183, params: RUBY_PARAMS, channel: RUBY_CHANNEL },
  { name: 'Продление', course_session_id: 60763, params: RUBY_PARAMS, channel: RUBY_CHANNEL },
  { name: 'VueJS | Поток: 1', course_session_id: 149636, params: VUEJS_PARAMS, channel: VUE_CHANNEL }
].freeze
