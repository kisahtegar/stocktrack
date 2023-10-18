package checkHealth

type (
	CheckHealthUsecase interface {
		CheckHealth() (string, error)
	}
)
