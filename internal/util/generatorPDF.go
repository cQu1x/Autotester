package util

import (
	"Autotester/internal/domain"
	"bytes"

	"github.com/jung-kurt/gofpdf"
)

func GeneratePDF(results []domain.Result) ([]byte, error) {
	var buf bytes.Buffer

	pdf := gofpdf.New("P", "mm", "A4", "")
	pdf.AddPage()
	pdf.SetFont("Arial", "B", 16)

	// Заголовок
	pdf.Cell(40, 10, "Результаты тестов")
	pdf.Ln(20)

	// Устанавливаем шрифт для результатов
	pdf.SetFont("Arial", "", 12)

	for _, r := range results {
		line := r.Test + ": "
		if r.Result {
			line += "PASSED"
		} else {
			line += "FAILED"
		}

		// Добавляем комментарий если есть
		if r.Comment != "" {
			line += " (" + r.Comment + ")"
		}

		pdf.Cell(40, 10, line)
		pdf.Ln(10)
	}

	err := pdf.Output(&buf)
	if err != nil {
		return nil, err
	}

	return buf.Bytes(), nil
}
