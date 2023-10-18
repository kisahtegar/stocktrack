package checkHealthUsecase

import "stocktrack_server/modules/checkHealth"

// struct for interface
type checkHealthUsecase struct{}

// NewCheckHealthUsecase is a constructor
func NewCheckHealthUsecase() checkHealth.CheckHealthUsecase {
	return &checkHealthUsecase{}
}

func (checkHealthUC *checkHealthUsecase) CheckHealth() (string, error) {
	ok := "stocktrack_server service is running"

	return ok, nil
}
