package com.absensi.backend.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class TokenParser {
  @JsonProperty("access_token")
  private String accessToken;

  @JsonProperty("expires_in")
  private int expiresIn;

  @JsonProperty("refresh_expires_in")
  private String refreshExpiresIn;

  @JsonProperty("refresh_token")
  private String refreshToken;
  @JsonProperty("token_type")
  private String tokenType;
  @JsonProperty("not_before_policy")
  private int notBeforePolicy;

  @JsonProperty("session_state")
  private String sessionState;

  @JsonProperty("scope")
  private int scope;
}
