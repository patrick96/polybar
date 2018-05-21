#include "components/config_parser.hpp"

POLYBAR_NS

config_parser::config_parser(const logger& logger, string&& file)
  : m_log(logger), m_file(forward<string>(file)) {

    if (!file_util::exists(m_file)) {
      throw application_error("Could not find config file: " + m_file);
    }

    m_log.trace("Parsing config file: %s", m_file);

  }

config_file parse() {
  return {};
}

void config_parser::parse_file(string file, file_list path) {
}

line_t config_parser::parse_line(int file_index, int line_no, string line) {
  return {};
}

line_type config_parser::get_line_type(string line) {
  if(line.empty()) {
    return line_type::EMPTY;
  }

  switch (line[0]) {
    case '[':
      return line_type::HEADER;

    case ';':
    case '#':
      return line_type::COMMENT;

    default:
      if(string_util::contains(line, "=")) {
        return line_type::KEY;
      }
      else {
        return line_type::UNKNOWN;
      }
  }
}

string config_parser::parse_header(string line) {
  if(line.back() != ']') {
    throw syntax_error("Missing ']' in header '" + line + "'");
  }

  string header = line.substr(1, line.size() - 2);

  if(!is_valid_name(header)) {
    throw invalid_name_error("Header", header);
  }

  return header;
}

std::pair<string, string> config_parser::parse_key(string line) {
  size_t pos = line.find_first_of('=');

  string key = trim(line.substr(0, pos), string_util::isnospace_pred);
  string value = trim(line.substr(pos + 1), string_util::isnospace_pred);

  if(!is_valid_name(key)) {
    throw invalid_name_error("Key", key);
  }

  /*
   * Remove double quotes around value, only if it starts end ends with
   * double quotes
   */
  if(value.size() >= 2 && value.front() == '"' && value.back() == '"') {
    value = value.substr(1, value.size() - 2);
  }

  return {key, value};
}

bool config_parser::is_valid_name(string name) {
  if(name.empty()) {
    return false;
  }

  for (size_t i = 0; i < name.size(); i++) {
    char c = name[i];
    // Names with forbidden chars or spaces are not valid
    if(isspace(c) || forbidden_chars.find_first_of(c) != string::npos) {
        return false;
      }
  }

  return true;
}

POLYBAR_NS_END