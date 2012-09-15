package main

import "testing"

func Test_Empty(t *testing.T) {
    D := New_Dependencies()

    if len(D.items) != 0 { t.Error() }
}

func Test_AddOneItemWithNoDependencies(t *testing.T) {
    D := New_Dependencies()
    D.add_direct("A", nil)

    if len(D.items) != 1 { t.Error() }
    if D.items["A"] != nil { t.Error() }
}

func Test_AddOneItemWithExistingDependencies(t *testing.T) {
    D := New_Dependencies()
    D.add_direct("A", []string{"A"})

    if len(D.items) != 1 { t.Error() }
    if len(D.items["A"]) != 1 { t.Error() }
    if D.items["A"][0] != "A" { t.Error() }
}

func Test_AddOneItemWithUnexistingDependencies(t *testing.T) {
    D := New_Dependencies()
    D.add_direct("A", []string{"B"})

    if len(D.items) != 2 { t.Error() }
    if len(D.items["A"]) != 1 { t.Error() }
    if len(D.items["B"]) != 0 { t.Error() }
    if D.items["A"][0] != "B" { t.Error() }
}

func Test_NoDependencies(t *testing.T) {
    D := New_Dependencies()
    D.add_direct("A", nil)

    A_dependencies := D.dependencies_for("A")

    if len(A_dependencies) != 0 { t.Error() }
}

func Test_OneDependencies(t *testing.T) {
    D := New_Dependencies()
    D.add_direct("A", []string{"B"})

    A_dependencies := D.dependencies_for("A")

    if len(A_dependencies) != 1 { t.Error() }
    if A_dependencies[0]   != "B" { t.Error() }
}
