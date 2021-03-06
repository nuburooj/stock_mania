import React from "react";
import { connect } from "react-redux";
import { login, clearErrors } from "../../../actions/session_actions";
import LoginForm from "./login_form";

const mapStateToProps = (state) => {
  return {
    state: state,
  };
};

const mapDispatchToProps = (dispatch) => {
  return {
    processForm: (currentUser) => dispatch(login(currentUser)),
    // clearErrors: () => dispatch(clearErrors()),
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(LoginForm);