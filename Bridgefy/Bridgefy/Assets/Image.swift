//
//  Image.swift
//  Bridgefy
//
//  Created by Jairo Lopez on 27/09/22.
//

import Foundation
import UIKit

class ImageFromPDF {
    
    static func drawIMGfromPDF(thisPDF: String) -> UIImage? {

        ///holt das PDF aus einem Verzeichnis im Programm
        ///nicht aus der 'Assets.xcassets'

        let path = Bundle.main.path(
            forResource: thisPDF,  //"fsm75-3 (Startstrecke)"
            ofType     : "pdf")  /////path to local file

        let url = URL(fileURLWithPath: path!)

        //following based on: https://www.hackingwithswift.com/example-code/core-graphics/how-to-render-a-pdf-to-an-image

        guard let document = CGPDFDocument(url as CFURL) else { return nil }
        guard let page = document.page(at: 1) else { return nil }

        let pageRect = page.getBoxRect(.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(pageRect)

            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)

            ctx.cgContext.drawPDFPage(page)
        }

        return img
    }
}
