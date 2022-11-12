//
//  SwiftBetaCanvas.swift
//  OpenAI
//
//  Created by Home on 5/11/22.
//

import SwiftUI

public struct SwiftBetaCanvas: View {
    @Binding var lines: [Line]
    @State var points: [Point] = []
    @State var currentLine: Int = 0
    @State var currentLineColor: Color = .red
    var currentLineWidth: Float
    
    public init(lines: Binding<[Line]>,
                currentLineWidth: Float) {
        self._lines = lines
        self.currentLineWidth = currentLineWidth
    }
    
    public var body: some View {
        Canvas { context, _ in
            createNewPath(context: context, lines: lines)
        }
        .gesture(
            DragGesture()
                .onChanged({ value in
                    let point = value.location
                    let lastPoint = points.isEmpty ? point : points.last!.currentPoint
                    let currentLinePoints = Point(currentPoint: point, lastPoint: lastPoint)
                    points.append(currentLinePoints)
                    
                    if lines.isEmpty {
                        let line = Line(points: [currentLinePoints],
                                        color: currentLineColor,
                                        width: currentLineWidth)
                        lines.append(line)
                    } else {
                        var line: Line?
                        
                        if currentLine >= lines.count {
                            line = Line(points: [currentLinePoints],
                                        color: currentLineColor,
                                        width: currentLineWidth)
                            lines.append(line!)
                        } else {
                            line = lines[currentLine]
                            line?.points = points
                            line?.color = currentLineColor
                        }
                        
                        if currentLine < lines.count {
                            lines[currentLine] = line!
                        }
                    }
                })
                .onEnded({ value in
                    currentLine += 1
                    points.removeAll()
                })
        )
        .background(Color.clear)
        .frame(width: 400, height: 400)
    }
    
    private func createNewPath(context: GraphicsContext,
                               lines: [Line]) {
        
        guard !lines.isEmpty else { return }
        
        for line in lines {
            var newPath = Path()
            for point in line.points {
                newPath.move(to: point.lastPoint)
                newPath.addLine(to: point.currentPoint)
            }
            context.stroke(newPath, with: .color(line.color), style: .init(lineWidth: CGFloat(line.width), lineCap: .round, lineJoin: .round))
        }
    }
}

struct SwiftBetaCanvas_Previews: PreviewProvider {
    static var previews: some View {
        SwiftBetaCanvas(lines: .constant([Line]()), currentLineWidth: 16)
    }
}
