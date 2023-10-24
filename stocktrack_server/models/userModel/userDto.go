package userModel

type (
	LoginRequest struct {
		Username string `json:"username" binding:"required"`
		Password string `json:"password" binding:"required"`
	}

	LoginResponse struct {
		Token        string `json:"token"`
		RefreshToken string `json:"refresh_token"`
	}
)
