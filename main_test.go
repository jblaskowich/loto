package main

import (
	"reflect"
	"testing"
)

func Test_sliceDeNombres(t *testing.T) {
	tests := []struct {
		name string
		args int
		want []int
	}{
		{"shortest", 1, []int{1}},
		{"short", 3, []int{1, 2, 3}},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := sliceDeNombres(tt.args); !reflect.DeepEqual(got, tt.want) {
				t.Errorf("sliceDeNombres(%d) = %v, want %v", tt.args, got, tt.want)
			}
		})
	}
}
