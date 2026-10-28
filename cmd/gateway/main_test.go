package main

import (
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestHealthz(t *testing.T) {
	resp := httptest.NewRecorder()
	req := httptest.NewRequest(http.MethodGet, "/healthz", nil)
	healthz(resp, req)
	if resp.Code != http.StatusOK {
		t.Errorf("healthz returned wrong status code: got %d want %d", resp.Code, http.StatusOK)
	}
}
